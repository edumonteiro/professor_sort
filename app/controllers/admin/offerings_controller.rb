class Admin::OfferingsController < ApplicationController

  before_filter :restrict_access
  before_filter :restrict_admin_access
  before_action :set_offering, only: [:show, :edit, :update, :destroy]


  def index
    @offerings = Offering.joins(:course).order("courses.name ASC")
    @new_offering = Offering.new
  end

  def new
    @offering = Offering.new
  end

  def create
    @offering = Offering.new(offering_params)
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


private
  # Use callbacks to share common setup or constraints between actions.
  def set_offering
    @offering = Offering.find(params[:id])
  end

  def offering_params
    params.require(:offering).permit(:course_id, :letter, :schedule, :professor_id)
  end

end
