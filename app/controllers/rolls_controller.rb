# coding: utf-8
class RollsController < ApplicationController
  before_action :authorize
  before_action :set_roll, only: [:show, :edit, :update]

  # def show
  # end

  def new
    gambling = Gambling.find(params[:gambling_id])
    roll = gambling.rolls.create! { |r| r.d1 = Roll.random_draw }
    redirect_to edit_gambling_roll_url(gambling, roll)
  end

  def edit
    @gambling = Gambling.find(params[:gambling_id])
    @game     = @gambling.game
    @rolls    = Roll.from_pg(@gambling.id) if @gambling.rolls.exists?
    @count    = @rolls.length unless @rolls.blank?
    @result   = 0
  end

  def update
    if @roll.update(roll_params)

      @gambling = Gambling.find(params[:gambling_id])

      if @roll.is_over
        cnt = @gambling.rolls.count
        if cnt < 65
          if @gambling.rolls.exists?(is_over: false)
            redirect_to edit_gambling_roll_url(@gambling, @gambling.rolls.where(is_over: false).last)
          else
            redirect_to new_gambling_roll_url(@gambling)
          end
        else
          if @gambling.rolls.exists?(is_over: false)
            redirect_to edit_gambling_roll_url(@gambling, @gambling.rolls.where(is_over: false).last)
          else
            @gambling.update_attribute(:is_over, true)
            redirect_to user_url(current_user)
          end
        end
        @roll.cleanup
      else
        redirect_to edit_gambling_roll_url(@gambling, @roll)
        @roll.update_attribute(:is_over, true) if @roll.n == 3
      end

    else
      redirect_to :back, alert: 'Tu ne peux plus enregistrer de ' + @roll.combination.name + ' en ' + @roll.col.name + ' !'
    end
  end

  private
    def set_roll
      @roll = Roll.find(params[:id])
    end

    def roll_params
      params.require(:roll).permit(:col_id, :combination_id, :dices, :d1, :d2, :d3, :erocs, :is_over, :keep, :memor, :n, :score)
    end

end
