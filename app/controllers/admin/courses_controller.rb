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
  end

  def update
  end
end
