# coding: utf-8
module ApplicationHelper
  def format_rolls(h)
    t_libre    = comput_total(h.values_at("11", "12", "13", "14", "15", "16"))
    t_descente = comput_total(h.values_at("21", "22", "23", "24", "25", "26"))
    t_montee   = comput_total(h.values_at("31", "32", "33", "34", "35", "36"))
    t_annonce  = comput_total(h.values_at("41", "42", "43", "44", "45", "46"))
    t_seche    = comput_total(h.values_at("51", "52", "53", "54", "55", "56"))
    b_libre    = comput_bonus(t_libre)
    b_descente = comput_bonus(t_descente)
    b_montee   = comput_bonus(t_montee)
    b_annonce  = comput_bonus(t_annonce)
    b_seche    = comput_bonus(t_seche)
    r = []
    r << '[{"id":1, "libre":'
    h["11"] ? r << h["11"] : r << 'null'
    r << ', "descente": '
    h["21"] ? r << h["21"] : r << 'null'
    r << ', "montee": '
    h["31"] ? r << h["31"] : r << 'null'
    r << ', "annonce": '
    h["41"] ? r << h["41"] : r << 'null'
    r << ', "seche": '
    h["51"] ? r << h["51"] : r << 'null'
    r << '}, {"id": 2,  "libre": '
    h["12"] ? r << h["12"] : r << 'null'
    r << ', "descente": '
    h["22"] ? r << h["22"] : r << 'null'
    r << ', "montee": '
    h["32"] ? r << h["32"] : r << 'null'
    r << ', "annonce": '
    h["42"] ? r << h["42"] : r << 'null'
    r << ', "seche": '
    h["52"] ? r << h["52"] : r << 'null'
    r << '}, {"id": 3,  "libre": '
    h["13"] ? r << h["13"] : r << 'null'
    r << ', "descente": '
    h["23"] ? r << h["23"] : r << 'null'
    r << ', "montee": '
    h["33"] ? r << h["33"] : r << 'null'
    r << ', "annonce": '
    h["43"] ? r << h["43"] : r << 'null'
    r << ', "seche": '
    h["53"] ? r << h["53"] : r << 'null'
    r << '}, {"id": 4,  "libre": '
    h["14"] ? r << h["14"] : r << 'null'
    r << ', "descente": '
    h["24"] ? r << h["24"] : r << 'null'
    r << ', "montee": '
    h["34"] ? r << h["34"] : r << 'null'
    r << ', "annonce": '
    h["44"] ? r << h["44"] : r << 'null'
    r << ', "seche": '
    h["54"] ? r << h["54"] : r << 'null'
    r << '}, {"id": 5,  "libre": '
    h["15"] ? r << h["15"] : r << 'null'
    r << ', "descente": '
    h["25"] ? r << h["25"] : r << 'null'
    r << ', "montee": '
    h["35"] ? r << h["35"] : r << 'null'
    r << ', "annonce": '
    h["45"] ? r << h["45"] : r << 'null'
    r << ', "seche": '
    h["55"] ? r << h["55"] : r << 'null'
    r << '}, {"id": 6,  "libre": '
    h["16"] ? r << h["16"] : r << 'null'
    r << ', "descente": '
    h["26"] ? r << h["26"] : r << 'null'
    r << ', "montee": '
    h["36"] ? r << h["36"] : r << 'null'
    r << ', "annonce": '
    h["46"] ? r << h["46"] : r << 'null'
    r << ', "seche": '
    h["56"] ? r << h["56"] : r << 'null'
    r << '}, {"id": "Total",  "libre": '
    r << t_libre
    r << ', "descente": '
    r << t_descente
    r << ', "montee": '
    r << t_montee
    r << ', "annonce": '
    r << t_annonce
    r << ', "seche": '
    r << t_seche
    r << '}, {"id": "Bonus",  "libre": '
    r << b_libre
    r << ', "descente": '
    r << b_descente
    r << ', "montee": '
    r << b_montee
    r << ', "annonce": '
    r << b_annonce
    r << ', "seche": '
    r << b_seche
    r << '}, {"id": "Plus",  "libre": '
    h["17"] ? r << h["17"] : r << 'null'
    r << ', "descente": '
    h["27"] ? r << h["27"] : r << 'null'
    r << ', "montee": '
    h["37"] ? r << h["37"] : r << 'null'
    r << ', "annonce": '
    h["47"] ? r << h["47"] : r << 'null'
    r << ', "seche": '
    h["57"] ? r << h["57"] : r << 'null'
    r << '}, {"id": "Moins",  "libre": '
    h["18"] ? r << h["18"] : r << 'null'
    r << ', "descente": '
    h["28"] ? r << h["28"] : r << 'null'
    r << ', "montee": '
    h["38"] ? r << h["38"] : r << 'null'
    r << ', "annonce": '
    h["48"] ? r << h["48"] : r << 'null'
    r << ', "seche": '
    h["58"] ? r << h["58"] : r << 'null'
    r << '}, {"id": "Full",  "libre": '
    h["19"] ? r << h["19"] : r << 'null'
    r << ', "descente": '
    h["29"] ? r << h["29"] : r << 'null'
    r << ', "montee": '
    h["39"] ? r << h["39"] : r << 'null'
    r << ', "annonce": '
    h["49"] ? r << h["49"] : r << 'null'
    r << ', "seche": '
    h["59"] ? r << h["59"] : r << 'null'
    r << '}, {"id": "Carré",  "libre": '
    h["110"] ? r << h["110"] : r << 'null'
    r << ', "descente": '
    h["210"] ? r << h["210"] : r << 'null'
    r << ', "montee": '
    h["310"] ? r << h["310"] : r << 'null'
    r << ', "annonce": '
    h["410"] ? r << h["410"] : r << 'null'
    r << ', "seche": '
    h["510"] ? r << h["510"] : r << 'null'
    r << '}, {"id": "Suite",  "libre": '
    h["111"] ? r << h["111"] : r << 'null'
    r << ', "descente": '
    h["211"] ? r << h["211"] : r << 'null'
    r << ', "montee": '
    h["311"] ? r << h["311"] : r << 'null'
    r << ', "annonce": '
    h["411"] ? r << h["411"] : r << 'null'
    r << ', "seche": '
    h["511"] ? r << h["511"] : r << 'null'
    r << '}, {"id": "Petiton",  "libre": '
    h["112"] ? r << h["112"] : r << 'null'
    r << ', "descente": '
    h["212"] ? r << h["212"] : r << 'null'
    r << ', "montee": '
    h["312"] ? r << h["312"] : r << 'null'
    r << ', "annonce": '
    h["412"] ? r << h["412"] : r << 'null'
    r << ', "seche": '
    h["512"] ? r << h["512"] : r << 'null'
    r << '}, {"id": "Yam",  "libre": '
    h["113"] ? r << h["113"] : r << 'null'
    r << ', "descente": '
    h["213"] ? r << h["213"] : r << 'null'
    r << ', "montee": '
    h["313"] ? r << h["313"] : r << 'null'
    r << ', "annonce": '
    h["413"] ? r << h["413"] : r << 'null'
    r << ', "seche": '
    h["513"] ? r << h["513"] : r << 'null'
    r << '}, {"id": "Résultat",  "libre": '
    r << sum_all(t_libre, b_libre, h.values_at("17", "18", "19", "110", "111", "112", "113"), 1)
    r << ', "descente": '
    r << sum_all(t_descente, b_descente, h.values_at("27", "28", "29", "210", "211", "212", "213"), 2)
    r << ', "montee": '
    r << sum_all(t_montee, b_montee, h.values_at("37", "38", "39", "310", "311", "312", "313"), 2)
    r << ', "annonce": '
    r << sum_all(t_annonce, b_annonce, h.values_at("47", "48", "49", "410", "411", "412", "413"), 3)
    r << ', "seche": '
    r << sum_all(t_seche, b_seche, h.values_at("57", "58", "59", "510", "511", "512", "513"), 4)
    r << '}]'
    r.join
  end
  def comput_total(a)
    r = a.each_with_object([]) { |i, a| a << i.to_i }.reduce(:+)
    r == 0 ? 'null' : r
  end
  def comput_bonus(total)
    if total == 'null'
      total
    elsif total >= 80
      total * 4
    elsif total >= 75
      total * 3
    elsif total >= 70
      total * 2
    elsif total >= 60
      30
    else
      'null'
    end
  end
  def sum_all(a, b, c, d)
    total = a == 'null' ? 0 : a
    bonus = b == 'null' ? 0 : b
    figures = c.each_with_object([]) { |i, o| o << i.to_i }.reduce(:+)
    s = (total + bonus + figures) * d
    @result += s if params[:controller] == "rolls"
    s == 0 ? 'null' : s
  end
  def mark_required(object, attribute)
    "*" if object.class.validators_on(attribute).map(&:class).include? ActiveModel::Validations::PresenceValidator
  end
end
