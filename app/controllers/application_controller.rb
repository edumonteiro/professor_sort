class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

    protected

    def restrict_access
      if !current_professor
        flash[:alert] = "You must log in."
        redirect_to new_session_path
      end
    end

    # def restrict_admin_access
    #   if current_professor.kind == 'admin'
    #     flash[:alert] = "You must be an Admin to access here."
    #     redirect_to movies_path
    #   end
    # end

    def current_professor
      @current_professor ||= Professor.find(session[:professor_id]) if session[:professor_id]
    end

    helper_method :current_professor
end
