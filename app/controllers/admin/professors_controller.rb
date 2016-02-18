class Admin::ProfessorsController < ApplicationController
  
  def index
    @professors = Professor.all
    @new_professor = Professor.new
  end

  def new
    @professor = Professor.new
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
  end

  def destroy
    @professor = Professor.find(params[:id])
    @professor.destroy
    redirect_to admin_professors_path
  end


   private
  
  def professor_params
    params.require(:professor).permit(:name, :email, :kind, :status)
  end
end
