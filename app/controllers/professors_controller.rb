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
    #this next if is for creating a super user that can edit the other professors kind
    #only this professor should use the admin code on the signup
      if @professor.kind == 'admin'
        new_config = Ourconfig.new
        new_config.name = "super_user_id"
        new_config.value = @professor.id 
        new_config.save       
      end
      session[:professor_id] = @professor.id
      redirect_to professor_path
    else
      render :new
    end
  end

  def show
    restrict_access
    @professor = current_professor
    redirect_to professor_preferences_path
  end

  def edit
    restrict_access
    @professor = current_professor
  end

  def update
    restrict_access
    @professor = current_professor
    if @professor.update_attributes(professor_params)
      redirect_to professor_path
    else
      render :edit
    end
  end

  def lectures
    @professor = current_professor
    @lectures = @professor.lectures    
  end

  protected
  def professor_params
    params.require(:professor).permit(:name, :email, :kind, :status, :password ,:password_confirmation)
    
  end
end
