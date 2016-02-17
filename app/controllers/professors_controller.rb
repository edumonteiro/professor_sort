class ProfessorsController < ApplicationController

  def new
    @prof = Professor.new
  end


  def create
    @prof = Professor.new(prof_params)    
  end

  def show
    @prof = current_prof
  end

  def edit
    @prof = current_prof
  end

  def update
    @prof = current_prof
  end

  protected
  def prof_params
    params.require(:professor).permit(:name, :email, :kind, :status)
    
  end
end
