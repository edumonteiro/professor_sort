class PreferencesController < ApplicationController
  before_filter :restrict_access

  def index
    @preferences = current_professor.preferences
  end

  def create
    @professor = current_professor
    @preference = @professor.preferences.build(preference_params)
    if @preference.save
      redirect_to professor_preferences_path
    else
      render :index
    end
  end

  def new
    @offerings = Offering.joins(:course).order("courses.name ASC")
    @preference = Preference.new

    #this only select offerings of Major
    @offering_major_selector = Offering.joins(:course).order("courses.name ASC").select{|offering|Course.find(offering.course_id).kind =='major'}
    #this only select offerings of Service
    @offering_service_selector = Offering.joins(:course).order("courses.name ASC").select{|offering|Course.find(offering.course_id).kind == 'service'}
    #Create the major selector array for dropdown form
    @offering_major_selector = @offering_major_selector.map do|offering|
        [Course.find(offering.course_id).name + " " + offering.letter, offering.id]
    end
    #Create the service selector array for dropdown form
    @offering_service_selector = @offering_service_selector.map do|offering|
        [Course.find(offering.course_id).name + " " + offering.letter, offering.id]
    end
  end

  protected
  def preference_params
    params.require(:preference).permit(:first_major, :second_major, :third_major, :first_service, :second_service, :third_service, :ttc_proposal_1, :ttc_proposal_2,:ttc_proposal_3, :comments, :semester)
  end

end
