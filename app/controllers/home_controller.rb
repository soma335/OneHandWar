class HomeController < ApplicationController
  def index
    @east = Combat.joins(:user).where(users: {belong:0}).sum(:battle_record)
    @west = Combat.joins(:user).where(users: {belong:1}).sum(:battle_record)
    @battle_data = {'東軍' => @east, '西軍' => @west}
  end

  def show
    if user_signed_in?
      @user_name = current_user.name
      unless Combat.find_by_id(user_id:current_user.id)
        @test = Combat.create(user_id: current_user.id)
      end
    end
  end
end