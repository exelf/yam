# coding: utf-8
class SessionsController < ApplicationController
  def new
  end

  def create
    player = Member.find_by_username(params[:username])
    if player && player.authenticate(params[:password])
      user = player.user
      session[:user_id] = user.id
      redirect_to user_url(user)
    else
      flash.now.alert = "L’identifiant ou le mot de passe est invalide."
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "A bientôt !"
  end
end
