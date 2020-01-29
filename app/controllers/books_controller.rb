class BooksController < ApplicationController

	before_action :authenticate_user!

	def show
		@book = Book.find(params[:id])
		@thebook = Book.new
		@user = User.new
		@theuser = @book.user
	end

	def index
		@books = Book.page(params[:page]).reverse_order
		@book = Book.new
		@user = @book.user
	end

	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if @book.save
			redirect_to book_path(@book.id), notice: 'Book successfully created !'
		else
		@books = Book.page(params[:page]).reverse_order
			render :index
		end
	end

	def edit
		@book = Book.find(params[:id])
		if @book.user != current_user
			redirect_to books_path
		end
	end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
			redirect_to book_path(book_params), notice: 'Book successfully updated !'
		else
			render :edit
		end
	end

	def destroy
		book = Book.find(params[:id])
		book.destroy
		redirect_to books_path
	end



	private
	def book_params
		params.require(:book).permit(:title, :body, :user_id)
	end
end
