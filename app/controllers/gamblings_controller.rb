# coding: utf-8
class GamblingsController < ApplicationController
  before_action :set_gambling, only: [:show, :destroy, :delete]

  def index
    gamblings = Gambling.joins("LEFT JOIN users ON users.id = gamblings.user_id LEFT JOIN members ON users.player_id = members.id AND users.player_type = 'Member'").order("gamblings.score desc").select("gamblings.id, gamblings.score, to_char(gamblings.updated_at, 'FMMonth DD, YYYY HH24:MI:SS') updated, members.username, members.email")
    day = gamblings.per_day
    week = gamblings.per_week - day
    month = gamblings.per_month - week - day
    @data = {
      "day"   => day,
      "week"  => week[0..9],
      "month" => month[0..9],
    }
  end

  def show
    @rolls = Roll.from_pg(@gambling.id)
  end

  def create
    if current_user.gamblings.exists?(is_over: false) 
      tsal = current_user.gamblings.where(is_over: false).last 
      roll = tsal.rolls.last
      redirect_to edit_gambling_roll_url(tsal, roll)
    else
      gambling = Gambling.create! do |g|
        g.game = Game.create!
        g.user = current_user
      end
      redirect_to new_gambling_roll_url(gambling)
    end
  end

  def delete
    roll = @gambling.rolls.where(is_over: true).last
    if roll.col_id == 4
      roll.update(score: nil, is_over: false)
    else
      roll.update(col_id: nil, combination_id: nil, score: nil, is_over: false)
    end
    redirect_to edit_gambling_roll_url(@gambling, roll)
  end

  def destroy
    @gambling.destroy
    redirect_to current_user
  end

  private
    def set_gambling
      @gambling = Gambling.find(params[:id])
    end
end
