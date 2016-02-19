class AdminController < ApplicationController
  
  before_filter :restrict_access
  before_filter :restrict_admin_access  

  def index
    
  end

end