class BooksController < ApplicationController
  def show
    user = User.find(session[:user_id])
    books = user.books
    render json: books
  end

  private

  def book_params
    params.require(:book).permit(:id)
  end
end
