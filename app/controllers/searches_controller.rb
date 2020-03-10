class SearchesController < ApplicationController

  def search
    @option = params[:search_option]
    method = params[:search_method]
    word = params[:search_word]
    if @option == "user_search"
      @users = User.params_user_search(method,word)
    elsif @option == "book_search"
      @books = Book.params_book_search(method,word)
    end
    render "searches/search_result"
  end
end
