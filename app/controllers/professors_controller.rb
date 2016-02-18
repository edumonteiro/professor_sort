class ProfessorsController < ApplicationController
  
  def new
    @professor = Professor.new
  end


  def create
    @professor = Professor.new(professor_params) 
    code1 = Ourconfig.find_by(name: "admin_code").value
    code2 = Ourconfig.find_by(name: "professor_code").value
    case professor_params[:kind].downcase
      when code1
        @professor.kind = 'admin' 
      when code2
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
