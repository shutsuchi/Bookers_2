class FavoritesController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    respond_to do |format|
      if favorite.save
        format.html
        format.js
      end
    end
    #favorite.save
    #  redirect_to book_path(book)
  end

  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    respond_to do |format|
      if favorite.destroy
        format.html
        format.js
      end
    end
    #favorite.destroy
    #  redirect_to book_path(book)
  end
end
