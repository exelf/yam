# coding: utf-8
class UsersController < ApplicationController
  def show
    @user = current_user
    @colors = @user.data.fetch('colors', ["ff0a23", "ffef0a", "1bff0a", "6c0aff"])
    if @user.gamblings.exists?(is_over: true)
      @gamblings = @user.gamblings.where("is_over").order("score desc").limit(10)
      @last = @gamblings.first 
    end
  end
end
