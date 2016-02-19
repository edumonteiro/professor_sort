class AdminController < ApplicationController
  
  before_filter :restrict_access
  before_filter :restrict_admin_access  

  def index
    
  end

  def semester
    semester = Ourconfig.find_by(name: 'semester')
    semester.value = params[:semester]
    if Ourconfig.validate_semester_format(semester)
      if semester.save
        flash[:alert] = "Successfully changed the semester."
        redirect_to admin_path
      else
        flash[:alert] = "Failed due to some unexpected error"
        redirect_to admin_path
      end
    else
      flash[:alert] = "You need to update the semester of the format 1/2012"
      redirect_to admin_path
    end
  end


end