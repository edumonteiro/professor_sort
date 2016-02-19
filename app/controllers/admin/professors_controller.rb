class Admin::ProfessorsController < ApplicationController

  before_filter :restrict_access
  before_filter :restrict_admin_access

  def index
    @professors = Professor.all
    @new_professor = Professor.new
  end


  def create
    @professor = Professor.new(professor_params)

    if @professor.save
      redirect_to admin_professors_path, notice: "#{@professor.name} was created successfully!"
    else
      render :index
    end
  end

  def edit
    @professor = Professor.find(params[:id])
  end

  def show
  end

  def update
    @professor = Professor.find(params[:id])
    if @professor.update_attributes(professor_params)
      redirect_to admin_professors_path
    else
      render :edit
    end
  end

  def destroy
    @professor = Professor.find(params[:id])
    @professor.destroy
    redirect_to admin_professors_path
  end

  def preferences
    @preferences = Professor.find(params[:professor_id]).preferences
  end

   private
  
  def professor_params
    params.require(:professor).permit(:name, :email, :kind, :status)
  end
end
