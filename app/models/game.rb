# coding: utf-8
class Game < ApplicationRecord

  # default scope

  # constants

  # attributes

  # associations
  has_many :gamblings
  has_many :users, :through => :gamblings

  # validations

  # callbacks

  # methods

end
