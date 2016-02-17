class Preference < ActiveRecord::Base
  belongs_to :professor
  belongs_to :offering

  # def display(off)
  #   Course.find(offering.course_id).name + " " + offering.letter, offering.id  
  # end



end
