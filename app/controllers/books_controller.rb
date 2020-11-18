class BooksController < ApplicationController
  def show
    params[:id] = session[:user_id] if params[:id] == "my_page"
    render json: User.find(params[:id]).books
  end

  def create
    user = User.find(session[:user_id])
    user.books.create(book_params)
    user.posts.create(
      content:"#{user.name}さんが「#{params[:book][:title]}」を本棚に登録しました。",
      image: params[:book][:image],
      name: user.name
    )
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
  end

  private

  def book_params
    params.require(:book).permit(:id, :title, :image, :tag_id)
  end
end
