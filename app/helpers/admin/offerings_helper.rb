module Admin::OfferingsHelper
  
  def self.decode_schedule(code)
    result = []
    code.split("").each do |value|
      case value
      when "a"
        result.push("Monday")
      when "b"
        resul.push("Tuesday")
      when "c"
        resul.push("Wednesday")
      when "d"
        resul.push("Thursday")
      when "e"
        resul.push("Friday")
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
      result      
    end
  end

end
