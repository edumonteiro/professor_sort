class Ourconfig < ActiveRecord::Base

  def self.validate_semester_format(semester)
    /^[012]\/20\d\d$/.match(semester.value) 
  end

end

