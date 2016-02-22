class Admin::PreferencesController < ApplicationController
  include Admin::PreferencesHelper
  

  # def index
  #     @preferences = Preference.where(semester: current_semester)
  #     # @professors = Professor.all
  #     @results = get_preference_bycourse(Offering.where(semester: current_semester))
  # end

  def professors
    @preferences = Preference.where(semester: current_semester)
  end


  def offerings
     @results = get_preference_bycourse(Offering.where(semester: current_semester))
  end

end