class Api::RakutenController < ApplicationController
  def search
    if params[:keyword]
      # books = RakutenWebService::Books::Book.search(title: params[:keyword])
      # render json: books
      render json: RakutenWebService::Books::Book.search(title: params[:keyword])
    end
  end
end
