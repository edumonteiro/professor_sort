class SessionsController < ApplicationController
  def new
  end

  def create
    professor = Professor.find_by(email: params[:email])
    if professor && professor.authenticate(params[:password])
      session[:professor_id] = professor.id
      if professor.kind == 'admin'
        redirect_to admin_path, notice: "Welcome to the admin page, #{professor.name}"
      else
        redirect_to professor_preferences_path,notice: "Welcome back, #{professor.name}!"
      end
    else
      render :new
    end
  end

  # def back_to_admin
  #   session[:user_id] = session[:me]
  #   session[:me] = nil
  #   redirect_to admin_users_path
  # end

  def destroy
    session[:professor_id] = nil
    redirect_to new_session_path, notice: "Adios!"
  end
  
end
