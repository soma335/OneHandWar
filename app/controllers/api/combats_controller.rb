class Api::CombatsController < ApplicationController
  before_action :authenticate_user!

  def index
    battle_all = Combat.all.sum(:battle_record)
    east_strength = Combat.joins(:user).where(users: {belong:0}).sum(:battle_record)
    west_strength = Combat.joins(:user).where(users: {belong:1}).sum(:battle_record)
    battle_record = Combat.joins(:user).where(users: {id:current_user.id}).sum(:battle_record)
    belong = current_user.belong
    user_name = current_user.name
    respond_to do |f|
      f.any {
        render json: [battle_all: battle_all.to_json, east_strength: east_strength.to_json,
                       west_strength: west_strength.to_json, battle_record: battle_record.to_json,
                       belong: belong.to_json, user_name: user_name.to_json]
      }
    end
  end

  def create
    combat = Combat.find_by(user_id: current_user.id)
    combat.update(combat_params)
    head :created
  end

  def update

  end

  def destroy
  end

  private

  def combat_params
    params.permit(:combat => [:battle_record]).require(:combat)
  end
end