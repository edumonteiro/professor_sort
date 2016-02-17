class Offering < ActiveRecord::Base
  belongs_to :course
  belongs_to :professor


  def self.decode_schedule(code)
    result = []
    code.split("").each do |value|
      case value
      when "a"
        result.push("Monday")
      when "b"
        result.push("Tuesday")
      when "c"
        result.push("Wednesday")
      when "d"
        result.push("Thursday")
      when "e"
        result.push("Friday")
      when "1"
        result.push("8 - 10")
      when "2"
        result.push("10 - 12")
      when "3"
        result.push("12 - 14")
      when "4"
        result.push("14 - 16")
      when "5"
        result.push("16 - 18")
      when "6"
        result.push("18 - 20")
      when "7"
        result.push("19 - 21")
      when "8"
        result.push("21 - 23")
      end     
    end
    result.join(" ") 
  end
end
