class Preference < ActiveRecord::Base
  belongs_to :professor
  # validates :ttc_proposal_1, presence: true
end
