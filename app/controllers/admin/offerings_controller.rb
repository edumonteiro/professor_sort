class Admin::OfferingsController < ApplicationController

  before_filter :restrict_access
  before_filter :restrict_admin_access
  before_action :set_offering, only: [:show, :edit, :update, :destroy]


  def index
    Copypref.populate_to_copyprefs
    @results = Magic.get_preference_bycourse_copy(Offering.where(semester: current_semester))
    @preferences = Preference.where(semester: current_semester)
    ##stuff in here are hidden unless being clicked
    @offerings = Offering.where(semester: current_semester)
    @offering = Offering.new
    #################
  end

  def new
    @offering = Offering.new
  end

  def create
    @offering = Offering.new(offering_params)
    @offering.semester = current_semester
    if @offering.save
      redirect_to admin_offerings_path
    else
      @offerings = Offering.where(semester: current_semester)
      @results = Magic.get_preference_bycourse_copy(Offering.where(semester: current_semester))
      @preferences = Preference.where(semester: current_semester)
      render :index
    end
  end

  def destroy
    @offering.destroy
    redirect_to admin_offerings_path
  end

  def edit
  end
  
  def update
    if @offering.update_attributes(offering_params)
      redirect_to admin_offerings_path
    else
      render :edit
    end
  end

  def clear_assignment
    Offering.where(semester: current_semester).each do |object|
      object.professor_id = nil
      object.save
    end
    Copypref.populate_to_copyprefs
    redirect_to admin_offerings_path
  end

  def resetprof
    @offering = Offering.find(params[:offering_id])
    @offering.professor_id = nil
    if @offering.save
      flash[:alert] = "Successfully reset the professor."
      redirect_to admin_offerings_path
    else
      flash[:alert] = "Failed due to some unexpected error."
      redirect_to admin_offerings_path
    end
  end

  def domagic
    Magic.do_magic
    redirect_to admin_offerings_path
  end

  def domagicalltheway
    Magic.do_magic_all_the_way
    redirect_to admin_offerings_path
  end

  def score
    begin 
      score = Magic.calculate_score(10,8,5)
    rescue
      score = ""
    end
    render plain: score
  end

  def random
    Magic.go_random(params[:number_of_random].to_i)
    redirect_to admin_offerings_path
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_offering
    @offering = Offering.find(params[:id])
  end

  def offering_params
    params.require(:offering).permit(:course_id, :letter, :schedule, :professor_id)
  end

end
