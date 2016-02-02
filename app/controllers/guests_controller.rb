# coding: utf-8
class GuestsController < ApplicationController
  def create
    user = User.create! { |u| u.player = Guest.create! }
    session[:user_id] = user.id
    redirect_to user_url(user)
  end
end