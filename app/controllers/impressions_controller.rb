class ImpressionsController < ApplicationController
  def index
    book_ids = "SELECT id FROM books WHERE user_id = #{session[:user_id]}"
    impressions = Impression.where("book_id IN (#{book_ids})")
    render json: impressions
  end
  
  # def show
  #   book = Book.find(params[:id])
  #   if book.impression
  #     render json: book.impression
  #   end
  # end

  def create
    book = Book.find(params[:impression][:book_id])
    book.create_impression(impression_params)
  end

  def update
    impression = Impression.find(params[:id])
    impression.update(impression_params)
  end

  def destroy
    impression = Impression.find(params[:id])
    impression.destroy
  end

  private

  def impression_params
    params.require(:impression).permit(:content, :book_id)
  end
end
