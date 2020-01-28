class BooksController < ApplicationController

	before_action :authenticate_user!

	def show
		@book = Book.find(params[:id])
		@thebook = Book.new
		@user = User.new
		@theuser = @book.user
	end

	def index
		@user = User.new
		@books = Book.page(params[:page]).reverse_order
		@book = Book.new
	end

	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if @book.save
			redirect_to book_path(@book.id), notice: 'Book successfully created !'
		else
			redirect_to users_path
		end
	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
			redirect_to book_path(book_params), notice: 'Book successfully updated !'
		end
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
