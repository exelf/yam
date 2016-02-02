# coding: utf-8
class User < ApplicationRecord

  # default scope

  # constants

  # attributes

  def colors
    a = "#"
    b = data.fetch('colors', ["ff0a23", "ffef0a", "1bff0a", "6c0aff"]).join("#")
    return a + b
  end

  # def colors=(string)
  #   colors = string.scan(/\w+/)
  #   self.data = {"colors" => colors}.to_json
  # end

  # associations
  belongs_to :player, polymorphic: true
  has_many :gamblings
  has_many :games, :through => :gamblings

  # validations

  # callbacks

  # methods
  delegate :guest?, :name, :become_member, to: :player

end
