class Api::RakutenController < ApplicationController
  def search
    if params[:keyword]
      render json: RakutenWebService::Books::Book.search(title: params[:keyword])
    end
  end
end
