class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    @book_comment = BookComment.find(params[:book_id]) 
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    respond_to do |format|
      if comment.save
        format.html
        format.js
      end
    end
    #comment.save
    #  redirect_to book_path(book)
  end
  def destroy
    book = Book.find(params[:book_id])
    @book_comment = BookComment.find(params[:book_id])
    comment = current_user.book_comments.find_by(book_id: book.id)
    respond_to do |format|
      if comment.save
        format.html
        format.js
      end
    end
    #comment.destroy
    #  redirect_to book_path(book)
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
