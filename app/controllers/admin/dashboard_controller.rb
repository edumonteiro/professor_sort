class Admin::DashboardController < ApplicationController
  
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
      else
        flash[:alert] = "Failed due to some unexpected error"
      end
    else
      flash[:alert] = "You need to update the semester in the format of either 0, 1 or 2, follow by backslash then year."
    end
      redirect_to admin_path
  end

  def notify_all
    @professors = Professor.all
    @professors.each do |professor|
      Admin::Dashboard.notify_all(professor).deliver
      flash[:alert] = "Attention, all emails had been sent. Time to fill up bitchesss!"
    end
    redirect_to admin_path
  end

end