# coding: utf-8
class Guest < ApplicationRecord

  # default scope

  # constants

  # attributes
  def guest?
    true
  end
  def name
    "curieux"
  end
  def time_zone
    "Paris"
  end
  def username
    ["Anonyme #", id].join
  end

  # associations
  has_one :user, as: :player, dependent: :destroy

  # validations

  # callbacks

  # methods
  def become_member(rebmem)
    user.player = rebmem
    user.save!
  end

end
