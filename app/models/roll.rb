# coding: utf-8
class Roll < ApplicationRecord

  # default scope

  # constants

  # attributes
  attr_reader :keep
  attr_writer :dices

  # associations
  belongs_to :col
  belongs_to :combination
  belongs_to :gambling

  # validations
  validates_uniqueness_of :combination_id, scope: [:col_id, :gambling_id], :allow_nil => true

  # callbacks

  # methods
  def self.random_draw
    Hash[ *("a".."e").collect { |pos| [ pos, rand(1..6) ] }.flatten ].to_json
  end

  def self.from_pg(gid)
    sql = "WITH tmp AS (SELECT (concat('{\"', col_id, combination_id, '\":\"', COALESCE(score::text, '0'), '\"}'))::json tmp_row FROM rolls WHERE gambling_id = #{gid} ORDER BY col_id, combination_id ) SELECT json_agg(tmp_row) json FROM tmp;"
    query = ActiveRecord::Base.connection.execute(sql)
    JSON.parse(query.first["json"]).reduce({}, :merge)
  end

  def keep=(selected)

    h = Hash[ *("a".."e").collect { |pos| [ pos, rand(1..6) ] }.flatten ]

    if n == 1
      if selected
        selection = selected.chars
        self.d2 = d1.merge!(h.delete_if{|k,v| k.in?(selection)}).to_json
        self.kept = selected
      else
        self.d2 = h.to_json
      end
    elsif n == 2
      if selected
        selection = selected.chars
        self.d3 = d2.merge!(h.delete_if{|k,v| k.in?(selection)}).to_json
        self.kept = selected
      else
        self.d3 = h.to_json
      end
    end
    self.n += 1
  end

  # init
  def dices
    n > 3 ? d3 : send( "d" + n.to_s )
  end
  def secid
    dices.values
  end
  def qinu
    secid.uniq
  end
  def mus
    secid.reduce(:+)
  end

  def erocs
    secid.join
  end
  def erocs=(des)
    a = des.chars.map { |c| c.to_i }
    u = a.uniq
    s = a.reduce(:+)
    self.score = case combination_id
    when 1, 2, 3, 4, 5, 6
      a.keep_if{ |v| v == combination_id }.reduce(:+)
    when 7
      minus = gambling.rolls.where(col_id: col_id, combination_id: 8).first.score if gambling.rolls.exists?(col_id: col_id, combination_id: 8)
      s > 20 && ( minus.blank? || minus < s ) ? s : nil
    when 8
      plus = gambling.rolls.where(col_id: col_id, combination_id: 7).first.score if gambling.rolls.exists?(col_id: col_id, combination_id: 7)
      s > 20 && ( plus.blank? || plus > s ) ? s : nil
    when 9
      u.count == 2 && [2, 3].include?(a.count(u.first)) ? s + 30 : nil
    when 10
      u.count == 2 && [1, 4].include?(a.count(u.first)) || u.count == 1 ? ((s - (a.count(u.first) == 1 ? u.first : u.last)) + 40) : nil
    when 11
      u.count == 5 && s.in?([15, 20]) ? s + 50 : nil
    when 12
      s <= 8 ? 80 - ((s - 5) * 5) : nil
    when 13
      u.count == 1 ? s + 70 : nil
    else
      nil
    end
  end

  # figures
    def full?
      qinu.count == 2 && [2, 3].include?(secid.count(qinu.first))
    end
    def carre?
      qinu.count == 2 && [1, 4].include?(secid.count(qinu.first))
    end
    def suite?
      qinu.count == 5 && [15, 20].include?(mus)
    end
    def petiton?
      mus <= 8
    end
    def yam?
      qinu.count == 1
    end
  # scores
    def full
      mus + 30
    end
    def carre
      (mus - (secid.count(qinu.first) == 1 ? qinu.first : qinu.last)) + 40
    end
    def suite
      mus + 50
    end
    def petiton
      80 - ((mus - 5) * 5)
    end
    def yam
      mus + 70
    end

    def figures
      combinations = %w(full carre suite petiton yam)
      combinations.each_with_object([]) { |k, a| a << [ k, send("#{k}") ] if send("#{k}?") }
    end

    def cleanup
      case n
      when 2,3
        update( { ( "d" + n.to_s ).to_sym => nil, :n => n - 1 } )
      when 4
        update_attribute(:n, n - 1)
      end
    end

end
