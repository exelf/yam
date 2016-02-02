# coding: utf-8
class Gambling < ApplicationRecord

  # default scope

  # constants

  # attributes

  # associations
  belongs_to :game
  belongs_to :user
  has_many   :rolls, dependent: :destroy

  # validations

  # callbacks
  before_save do
    if is_over
      alpha = 0
      h = Roll.from_pg(id)
      l = [ h.values_at("11", "12", "13", "14", "15", "16").collect { |i| i.to_i }.reduce(:+), h.values_at("17", "18", "19", "110", "111", "112", "113").collect { |i| i.to_i }.reduce(:+), 1 ]
      d = [ h.values_at("21", "22", "23", "24", "25", "26").collect { |i| i.to_i }.reduce(:+), h.values_at("27", "28", "29", "210", "211", "212", "213").collect { |i| i.to_i }.reduce(:+), 2 ]
      m = [ h.values_at("31", "32", "33", "34", "35", "36").collect { |i| i.to_i }.reduce(:+), h.values_at("37", "38", "39", "310", "311", "312", "313").collect { |i| i.to_i }.reduce(:+), 2 ]
      a = [ h.values_at("41", "42", "43", "44", "45", "46").collect { |i| i.to_i }.reduce(:+), h.values_at("47", "48", "49", "410", "411", "412", "413").collect { |i| i.to_i }.reduce(:+), 3 ]
      s = [ h.values_at("51", "52", "53", "54", "55", "56").collect { |i| i.to_i }.reduce(:+), h.values_at("57", "58", "59", "510", "511", "512", "513").collect { |i| i.to_i }.reduce(:+), 4 ]
      [l, d, m, a, s].each do |o|
        o << total(o[0])
        alpha += (o[0] + o[1] + o[3]) * o[2]
      end
      self.score = alpha
    end
  end

  # methods
  scope :isover,    -> { where("is_over") }
  scope :per_day,   -> { isover.where("gamblings.updated_at >= ?", Time.current.advance(days: -1)) }
  scope :per_month, -> { isover.where("gamblings.updated_at >= ?", Time.current.advance(months: -1)) }
  scope :per_week,  -> { isover.where("gamblings.updated_at >= ?", Time.current.advance(weeks: -1)) }
  scope :per_year,  -> { isover.where("gamblings.updated_at >= ?", Time.current.advance(years: -1)) }

  def start
    I18n.localize updated_at.in_time_zone, format: :short
  end

  def reyalp
    user.player.username
  end

  def total(t)
    if t > 79
      t * 4
    elsif t > 74
      t * 3
    elsif t > 69
      t * 2
    elsif t > 59
      30
    else
      0
    end
  end

end
