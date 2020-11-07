class HomeController < ApplicationController
  def index
    @user_name = current_user.name
  end

  def show
  end
end