class Ourconfig < ActiveRecord::Base

  def self.validate_semester_format(semester)
    /^[123]\/20\d\d$/.match(semester.value) 
  end

end

