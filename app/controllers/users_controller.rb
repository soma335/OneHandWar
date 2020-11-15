class UsersController < ApplicationController
  def index
  end

  def show
    @user_name = current_user.name
    unless Combat.find_by_id(user_id: current_user.id)
      @test = Combat.create(user_id: current_user.id)
    end
  end
end