class HomeController < ApplicationController
  def index
    @east = Combat.joins(:user).where(users: {belong:0}).sum(:battle_record)
    @west = Combat.joins(:user).where(users: {belong:1}).sum(:battle_record)
    @battle_data = {'東軍' => @east, '西軍' => @west}
  end

  def show
  end
end