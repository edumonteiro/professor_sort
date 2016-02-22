class Professor < ActiveRecord::Base
  has_secure_password
  has_many :preferences
  has_many :lectures

end
