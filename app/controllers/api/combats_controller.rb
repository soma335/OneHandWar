class Api::CombatsController < ApplicationController
  before_action :authenticate_user!


  def index
    @battle = Combat.all.sum(:battle_record)
    @east = Combat.joins(:user).where(users: {belong:0}).sum(:battle_record)
    @west = Combat.joins(:user).where(users: {belong:1}).sum(:battle_record)
    @battle_record = Combat.joins(:user).where(users: {id:current_user.id}).sum(:battle_record)
    @belong = current_user.belong
    @user_name = current_user.name
    respond_to do |f|
      f.any { render json: [ battle: @battle.to_json, east: @east.to_json, west: @west.to_json, battle_record: @battle_record.to_json, belong: @belong.to_json, user_name: @user_name.to_json ] }
    end
  end

  def create
    @test = Combat.find(current_user.id)
    @test.update(combat_params)
    head :created
  end

  def update

  end

  def destroy
    current_user.likes.find(params[:id]).destroy!
    head :ok
  end

  private

  def combat_params
    params.fetch(:combat, {}).permit([:battle_record])
  end
end