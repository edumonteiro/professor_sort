class Preference < ActiveRecord::Base
  belongs_to :professor
  belongs_to :offering

    

end
