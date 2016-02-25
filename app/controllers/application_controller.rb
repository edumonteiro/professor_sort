class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
 


  def current_semester       
    Magic.current_semester
  end

  def get_info(offering_id)
    offering = Offering.find(offering_id)
    name = offering.course.name
    if offering.course.kind == "major"
      pref1 =Preference.where(first_major: offering_id)
      prof_first_choice = []
      pref1.each do |preference|
        prof_first_choice.push(preference.professor.name)
      end
      prof_second_choice = []
      pref2 =Preference.where(second_major: offering_id)
      pref2.each do |preference|
        prof_second_choice.push(preference.professor.name)
      end
      prof_third_choice = []
      pref3 =Preference.where(third_major: offering_id)
      pref3.each do |preference|
        prof_third_choice.push(preference.professor.name)
      end      
    else
      pref1 =Preference.where(first_service: offering_id)
      prof_first_choice = []
      pref1.each do |preference|
        prof_first_choice.push(preference.professor.name)
      end
      prof_second_choice = []
      pref2 =Preference.where(second_service: offering_id)
      pref2.each do |preference|
        prof_second_choice.push(preference.professor.name)
      end
      prof_third_choice = []
      pref3 =Preference.where(third_service: offering_id)


      pref3.each do |preference|
        prof_third_choice.push(preference.professor.name)
      end       
    end      
    result = {}
    result[:course] = name
    result[:letter] = offering.letter
    result[:schedule] = offering.schedule
    result[:semester] = offering.semester
    result[:first_choice_of] = prof_first_choice
    result[:second_choice_of] = prof_second_choice
    result[:third_choice_of] = prof_third_choice
    result[:offering_id] = offering_id
    result
  end

  #Creates arrays one for major and one for service of hashes with information about preferences
  def get_preference_bycourse(offerings)
    major_offering_ids = []
    service_offering_ids =[]
    offerings.each do |offering|
      if offering.course.kind == "major"
        major_offering_ids.push(offering.id)
      else
        service_offering_ids.push(offering.id)
      end
    end
    organized_major_pref = []
    major_offering_ids.each do |offering|
      organized_major_pref.push(get_info(offering))
    end
    organized_service_pref = []
    service_offering_ids.each do |offering|
      organized_service_pref.push(get_info(offering))
    end
    organized = [organized_major_pref,organized_service_pref]
    organized
  end

  #gets the history of preferences for every courses by every offering of that course
  def course_preferences_reporter
    result = []
    Course.all.each do |course|
      course.offerings.each do |offering|
        report = {}
        report[:course_name] = offering.course.name
        report[:letter] = offering.letter
        report[:schedule] = offering.schedule
        report[:semester] = offering.semester
        if course.kind == "major"
          report[:first_choice_of] = Preference.where(first_major: offering.id).pluck(:professor_id)
          report[:second_choice_of] = Preference.where(second_major: offering.id).pluck(:professor_id)
          report[:third_choice_of] = Preference.where(third_major: offering.id).pluck(:professor_id)
        else
          report[:first_choice_of] = Preference.where(first_service: offering.id).pluck(:professor_id)
          report[:second_choice_of] = Preference.where(second_service: offering.id).pluck(:professor_id)
          report[:third_choice_of] = Preference.where(third_service: offering.id).pluck(:professor_id)
        end
        result << report
      end
    end
    result
  end

  #filters results returned by previous methods by a single course name
  def display_report(results,course)
    results.select {|hash| hash[:course_name] == course}
  end

  def decode_semester(date_format)
    result = nil
    case date_format.month
    when 1
      result = 0
    when 3
      result = 1
    when 8
      result = 2    
    end
    "#{result}/#{date_format.year}"
  end


  def group_service_preferences_by_schedule(results)
    uniq_schedules = Course.joins("LEFT OUTER JOIN offerings ON courses.id=offerings.course_id").pluck(:schedule).uniq    
    service_ids = Course.where(kind: "service").pluck(:id)
    result = []
    uniq_schedules.each do |schedule|
      service_ids.each do |service_id|
        hash = {}
        hash[:first_choice_of] = []
        hash[:second_choice_of] = []
        hash[:third_choice_of] = []
        group = results.select {|singular| singular[:course] == Course.find(service_id).name && singular[:schedule] == schedule }
          group.each do |preference|
            hash[:first_choice_of].concat(preference[:first_choice_of])
            hash[:second_choice_of].concat(preference[:second_choice_of])
            hash[:third_choice_of].concat(preference[:third_choice_of])
            hash[:course] = preference[:course]
            hash[:schedule] = preference[:schedule]            
          end
        result << hash
      end
    end
  result
  result = result.select {|x| x.has_key?(:course)}
  result
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
  helper_method :decode_semester
  helper_method :get_info
  helper_method :get_preference_bycourse
  helper_method :course_preferences_reporter
  helper_method :display_report
  helper_method :group_service_preferences_by_schedule
end
