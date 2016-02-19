module Admin::PreferencesHelper


  def get_info(offering_id)
    offering = Offering.find(offering_id)
    name = offering.course.name
    pref1 = Preference.where(first_major: offering_id)
    prof_first_choice = []
    pref1.each do |preference|
      prof_first_choice.push(preference.professor.name)
    end
    prof_second_choice = []
    pref2 = Preference.where(second_major: offering_id)
    pref2.each do |preference|
      prof_second_choice.push(preference.professor.name)
    end
    prof_third_choice = []
    pref3 = Preference.where(third_major: offering_id)
    pref3.each do |preference|
      prof_third_choice.push(preference.professor.name)
    end
    result = {}
    result[:course] = name
    result[:first_choice_of] = prof_first_choice
    result[:second_choice_of] = prof_second_choice
    result[:third_choice_of] = prof_third_choice
    result
  end

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

end