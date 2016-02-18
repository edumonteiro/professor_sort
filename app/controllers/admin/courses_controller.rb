class Admin::CoursesController < ApplicationController
  

  def index
    @courses = Course.all
    @new_course = Course.new
  end


  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to admin_courses_path, notice: "#{@course.name} was created successfully!"
    else
      render :index
    end
  end

  def edit
    @course = Course.find(params[:id])
  end

  def show
    @course = Course.find(params[:id])
    #since the course has just a few informations no view for show was created and
    #this json part was created to define the number of credits and customize the offering schedule form
    respond_to do |format|
      format.html
      format.json { render :json => @course.credits.to_json }
    end
  end

  def update
        @course = Course.find(params[:id])

        if @course.update_attributes(course_params)
          redirect_to admin_courses_path
        else
          render :edit
        end
      end

      def destroy
        @course = Course.find(params[:id])
        @course.destroy
        redirect_to admin_courses_path
      end


  private
  
  def course_params
    params.require(:course).permit(:name, :credits, :kind)
  end

end

