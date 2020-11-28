class ImpressionsController < ApplicationController
  before_action :logged_in_user, only: [:create, :update, :destroy]
  before_action :correct_user,   only: [:create, :update, :destroy]

  def index
    book_ids = "SELECT id FROM books WHERE user_id = #{session[:user_id]}"
    impressions = Impression.where("book_id IN (#{book_ids})")
    render json: impressions
  end
  
  def show
    book_ids = "SELECT id FROM books WHERE user_id = #{params[:id]}"
    impressions = Impression.where("book_id IN (#{book_ids})")
    render json: impressions
  end

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
