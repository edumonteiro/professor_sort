class Admin::OfferingsController < ApplicationController

  before_filter :restrict_access
  before_filter :restrict_admin_access
  before_action :set_offering, only: [:show, :edit, :update, :destroy]


  def index
    @offerings = Offering.where(semester: current_semester)
    @new_offering = Offering.new
  end

  def new
    @offering = Offering.new
  end

  def create
    @offering = Offering.new(offering_params)
    @offering.semester = current_semester
    @offering.save
    redirect_to admin_offerings_path
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


private
  # Use callbacks to share common setup or constraints between actions.
  def set_offering
    @offering = Offering.find(params[:id])
  end

  def offering_params
    params.require(:offering).permit(:course_id, :letter, :schedule, :professor_id)
  end

end
