class UsersController < ApplicationController

  before_action :authenticate_user!

  def following
    @title = "Following"
    @user = User.find(params[:user_id])
    @users = @user.following.page(params[:page]).reverse_order
    render 'followings'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:user_id])
    @users = @user.followers.page(params[:page]).reverse_order
    render 'followers'
  end

  def index
    @users = User.page(params[:page]).reverse_order
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = Book.page(params[:page]).reverse_order
    if @user == current_user
      geo = Geocoder.coordinates(@user.address_set)
      @lat = geo[0]
      @lng = geo[1]
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: 'User successfully updated !'
    else
       render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :postal_code, :prefecture, :city, :street)
  end

end
