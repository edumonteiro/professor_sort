class PreferencesController < ApplicationController

  def index
    @preferences = Preference.all
    @preference = Preference.new
    @offerings = Offering.all

    @offering_major_selector = Offering.joins(:course).order("courses.name ASC").select{|offering|Course.find(offering.course_id).kind =='major'}

    @offering_service_selector = Offering.joins(:course).order("courses.name ASC").select{|offering|Course.find(offering.course_id).kind == 'service'}

    @offering_major_selector = @offering_major_selector.map do|offering|
        [Course.find(offering.course_id).name + " " + offering.letter, offering.id]
    end

    @offering_service_selector = @offering_service_selector.map do|offering|
        [Course.find(offering.course_id).name + " " + offering.letter, offering.id]
    end

    respond_to do |format|
      format.html
      format.json { render :json => @asdasd.asdasd.to_json}
    end
  end

  def create
    @preference = Preference.new(preference_params)

    if @preference.save
      redirect_to professor_preferences_path,notice: "#{@preference.id} was submitted successfully!"
    else
      render :index
    end
  end


  protected
  def preference_params
    params.require(:preference).permit(:first_major, :second_major, :third_major, :first_service, :second_service, :third_service, :ttc_proposal_1, :ttc_proposal_2,:ttc_proposal_3, :comments, :semester)
  end
end
