class Course < ActiveRecord::Base
  has_many :offerings
  has_many :lectures

end
