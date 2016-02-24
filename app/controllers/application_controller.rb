class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
 


  def current_semester       
    Magic.current_semester
  end

  # def past_semester
  #   case current_semester.month
  #   when 1
  #     @past_semester = Date.new(current_semester.year-1,8)
  #   when 3
  #     @past_semester = Date.new(current_semester.year-1,8)
  #   when 8
  #     @past_semester = Date.new(current_semester.year,3)      
  #   end
  #   @past_semester
  # end

  # def twoago_semester
  #   case past_semester.month
  #   when 1
  #     @twoago_semester = Date.new(past_semester.year-1,8)
  #   when 3
  #     @twoago_semester = Date.new(past_semester.year-1,8)
  #   when 8
  #     @twoago_semester = Date.new(past_semester.year,3)      
  #   end
  #   @twoago_semester

  # end

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
  helper_method :past_semester
  helper_method :twoago_semester

end
