class Admin::PreferencesController < ApplicationController
  include Admin::PreferencesHelper
  

  def index
      @preferences = Preference.all
      @professors = Professor.all
      @results = get_preference_bycourse(Offering.all)
  end

end