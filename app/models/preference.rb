class Preference < ActiveRecord::Base
  belongs_to :professor
  belongs_to :offering
  validates :ttc_proposal_1, presence: true
end
