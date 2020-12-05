class HomeController < ApplicationController
  before_action :logged_in_user, only: [:index]

  def index
  end

  def top
  end

  def about
  end
end
