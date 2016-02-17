class Admin::CoursesController < ApplicationController
  

  def index
    @courses = Course.all
    @new_course = Course.new
  end

  def new
  end

  def create
  end

  def edit
  end

  def show
    @course = Course.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @course.credits.to_json }
    end
  end

  def update
  end
end
