class Admin::PreferencesController < ApplicationController

def index
    @preferences = Preference.all
    @professors = Professor.all
  end

end