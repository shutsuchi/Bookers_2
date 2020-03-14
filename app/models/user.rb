class User < ApplicationRecord

  include JpPrefecture

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :profile_image
  jp_prefecture :prefecture_code

  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent:  :destroy
  has_many :passive_relationships, class_name: 'Relationship',
                                    foreign_key: 'followed_id',
                                    dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  validates :name, presence: true,
                   length: { minimum: 2, maximum: 20 }
  validates :introduction, length: { maximum: 50 }

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def self.params_user_search(method,word)
    if method == "forward_match"
      @users = User.where("name LIKE?", "#{word}%")
    elsif method == "backward_match"
      @users = User.where("name LIKE?", "%#{word}")
    elsif method == "perfect_match"
      @users = User.where("name LIKE?", "#{word}")
    elsif method == "partial_match"
      @users = User.where("name LIKE?", "%#{word}%")
    else
      @users = User.all
    end
  end

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  def address_set
    prefecture_name = JpPrefecture::Prefecture.find(self.prefecture_code).name
    prefecture_name + self.city
  end

end
