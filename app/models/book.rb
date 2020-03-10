class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  validates :title, presence: true
  validates :body, presence: true,
                  length: { maximum: 200 }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.params_book_search(method,word)
    #when params[:book].present? && params[:book][:title]
      if method == "forward_match"
        @books = Book.where("title LIKE?", "#{word}%")
      elsif method == "backward_match"
        @books = Book.where("title LIKE?", "%#{word}")
      elsif method == "perfect_match"
        @books = Book.where("title LIKE?", "#{word}")
      elsif method == "partial_match"
        @books = Book.where("title LIKE?", "%#{word}%")
      else
        @books = Book.all
      end
  end

end
