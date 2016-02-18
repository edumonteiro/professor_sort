class ProfessorsController < ApplicationController
  
  def new
    @professor = Professor.new
  end


  def create
    @professor = Professor.new(professor_params) 
    case professor_params[:kind].downcase
      when 'secret'
        @professor.kind = 'admin' 
      when 'whatever'
        @professor.kind = 'professor'
      else
        @professor.kind = nil
    end
    if @professor.kind && @professor.save
      session[:professor_id] = @professor.id
      redirect_to professor_path
    else
      render :new
    end
  end

  def show
    restrict_access
    @professor = current_professor
  end

  def edit
    @professor = current_professor
  end

  def update
    @professor = current_professor
  end

  protected
  def professor_params
    params.require(:professor).permit(:name, :email, :kind, :status, :password ,:password_confirmation)
    
  end
end
