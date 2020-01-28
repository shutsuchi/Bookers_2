class BooksController < ApplicationController

	before_action :authenticate_user!

	def show
		@book = Book.find(params[:id])
	end

	def index
		@user = User.new
		@books = Book.all
		@book = Book.new
	end

	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if @book.save
			redirect_to book_path(@book.id)
		else
			redirect_to users_path
		end
	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
		book = Book.find(params[:id])
		book.update
		redirect_to book_path(book_params)
	end

	def destroy
		book = Book.find(params[:id])
		book.destroy
		redirect_to books_path
	end

	private
	def book_params
		params.require(:book).permit(:title, :body)
	end
end
