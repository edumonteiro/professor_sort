class Copypref < ActiveRecord::Base
  belongs_to :professor
  belongs_to :offering


  def self.populate_to_copyprefs
    Copypref.destroy_all

    preferences = Preference.where(semester: Date.new(2016,3))
    preferences.each do |preference|
      me = Copypref.new
      me.professor_id = preference.professor_id
      me.offering_id = preference.offering_id
      me.first_major = preference.first_major
      me.second_major = preference.second_major
      me.third_major = preference.third_major
      me.first_service = preference.first_service
      me.second_service = preference.second_service
      me.third_service = preference.third_service
      me.ttc_proposal_1 = preference.ttc_proposal_1
      me.ttc_proposal_2 = preference.ttc_proposal_2
      me.ttc_proposal_3 = preference.ttc_proposal_3
      me.comments = preference.comments
      me.semester = preference.semester
      me.save
    end
  end

end