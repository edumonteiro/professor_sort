  class PreferencesController < ApplicationController
  
  before_filter :restrict_access


  def index
    @preferences = current_professor.preferences
    @addable = addable?(current_professor,current_semester)
  end

  def create
    @professor = current_professor
    @preference = @professor.preferences.build(preference_params)
    @preference.semester = current_semester
    if @preference.save
      redirect_to professor_preferences_path
    else
      render :index
    end
  end

  def show
    @results = get_preference_bycourse(Offering.all)
  end

  def new
    if addable?(current_professor,current_semester)
      @offerings = Offering.where(semester: current_semester)
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
    else
      redirect_to professor_preferences_path
    end
  end

  def destroy
    @preference = Preference.find(params[:id])
    @preference.destroy
    redirect_to professor_preferences_path
  end

  protected
  def preference_params
    params.require(:preference).permit(:first_major, :second_major, :third_major, :first_service, :second_service, :third_service, :ttc_proposal_1, :ttc_proposal_2,:ttc_proposal_3, :comments, :semester)
  end

  def addable?(current_professor,current_semester)
    !current_professor.preferences.where(semester: current_semester).pluck(:professor_id).include?(current_professor.id)
  end

end
