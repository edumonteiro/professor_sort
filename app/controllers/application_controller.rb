class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
 


  def current_semester
    @current_semester = nil
    semester = Ourconfig.find_by(name: "semester").value.split("/")
    case semester[0]
    when "0"
      @current_semester = Date.new(semester[1].to_i,1)
    when "1"
      @current_semester = Date.new(semester[1].to_i,3)
    when "2"
      @current_semester = Date.new(semester[1].to_i,8)
    end
    @current_semester        
    # Solution.current_semester
  end

  protected

  def restrict_access
    if !current_professor
      flash[:alert] = "You must log in."
      redirect_to new_session_path
    end
  end

  def restrict_admin_access
    if current_professor.kind != 'admin'
      flash[:alert] = "You must be an Admin to access the admin pages."
      redirect_to professor_path
    end
  end


  def current_professor
    @current_professor ||= Professor.find(session[:professor_id]) if session[:professor_id]
  end

  helper_method :current_professor
  helper_method :current_semester

end
