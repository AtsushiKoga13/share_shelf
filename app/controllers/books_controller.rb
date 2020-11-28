class BooksController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :change_tag]
  before_action :correct_user,   only: [:create, :destroy, :change_tag]

  def show
    params[:id] = session[:user_id] if params[:id] == "my_page"
    render json: User.find(params[:id]).books
  end

  def create
    current_user.books.create(book_params)
    current_user.create_book_post(current_user, params[:book][:title], params[:book][:image])
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
  end

  def change_tag
    current_user.books.find(params[:id]).update(book_params)
  end

  private

  def book_params
    params.require(:book).permit(:id, :title, :image, :tag_id)
  end
end
