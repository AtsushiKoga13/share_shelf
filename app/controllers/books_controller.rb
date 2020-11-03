class BooksController < ApplicationController
  def show
    user = User.find(session[:user_id])
    books = user.books
    render json: books
  end

  def create
    user = User.find(session[:user_id])
    user.books.create(book_params)
  end

  private

  def book_params
    params.require(:book).permit(:id, :title, :image)
  end
end
