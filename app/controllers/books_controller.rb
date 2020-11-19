class BooksController < ApplicationController
  def show
    params[:id] = session[:user_id] if params[:id] == "my_page"
    render json: User.find(params[:id]).books
  end

  def create
    user = User.find(session[:user_id])
    user.books.create(book_params)
    user.create_book_post(user,params[:book][:title],params[:book][:image])
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
  end

  def change_tag
    user = User.find(session[:user_id])
    user.books.find(params[:id]).update(tag_id: params[:book][:tag_id])
  end

  private

  def book_params
    params.require(:book).permit(:id, :title, :image, :tag_id)
  end
end
