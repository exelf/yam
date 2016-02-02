# coding: utf-8
class MembersController < ApplicationController
  before_action :set_member, only: [:edit, :update]

  def new
    @member = Member.new
  end

  def create
    @member = Member.new(member_params)
    if @member.save
      current_user.become_member(@member)
      redirect_to user_url(current_user)
    else
      render "new"
    end
  end

  # def edit
  # end

  # def update
  #   if @member.update_attributes(member_params)
  #     redirect_to user_url(@member.user), notice: "Votre profil a été modifié."
  #   else
  #     render :edit
  #   end
  # end

end

private
  def set_member
    @member = Member.find(params[:id])
  end

  def member_params
    # params.require(:member).permit(:username, :email, :password, :password_confirmation, :time_zone, user_attributes: [ :id, :colors ])
    params.require(:member).permit(:username, :email, :password)
  end
