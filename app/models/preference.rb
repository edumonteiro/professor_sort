class Preference < ActiveRecord::Base
  belongs_to :professor
  # validates :ttc_proposal_1, presence: true
  validate :uniq_preference_major?
  validate :uniq_preference_service?

  def uniq_preference_major?
    if (self.first_major == self.second_major || self.first_major == self.third_major || self.second_major == self.third_major)
      errors.add(:base,"Major preferences must be distinct.")
    end
  end

   def uniq_preference_service?
    if self.first_service == self.second_service || self.first_service == self.third_service || self.second_service == self.third_service
      errors.add(:base,"Service preferences must be distinct.")
    end
  end
end
