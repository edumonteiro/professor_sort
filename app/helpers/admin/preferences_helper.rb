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

end