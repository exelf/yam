# coding: utf-8
class Member < ApplicationRecord

  # default scope

  # constants

  # attributes
  def guest?
    false
  end
  def name
    username
  end

  # associations
  has_one :user, as: :player, dependent: :destroy

  # validations
  validates :username, :presence => true, :uniqueness => true
  validates :email, :presence => true, :uniqueness => true

  # callbacks

  # methods
  has_secure_password
  # accepts_nested_attributes_for :user

end
