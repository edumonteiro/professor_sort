class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if user.admin
        redirect_to admin_users_path, notice: "Welcome to the admin page, #{user.full_name}"
      else
        redirect_to movies_path,notice: "Welcome back, #{user.full_name}!"
      end
    else
      render :new
    end
  end

  def back_to_admin
    session[:user_id] = session[:me]
    session[:me] = nil
    redirect_to admin_users_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to movies_path, notice: "Adios!"
  end
  
end
