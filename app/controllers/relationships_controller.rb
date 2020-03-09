class RelationshipsController < ApplicationController
  
  def create
    #binding.pry
    user = User.find(params[:followed_id])
    current_user.follow(user)
    redirect_to user
  end

  def destroy
    #binding.pry
    user = Relationship.find_by(params[:id]).followed
    current_user.unfollow(user)
    redirect_to user
  end
end
