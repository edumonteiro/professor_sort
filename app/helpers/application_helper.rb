module ApplicationHelper

  

  def get_professors_and_offerings_for_assigning
    offering_to_be_assigned = Offering.where(semester: current_semester).where(professor_id: nil).pluck(:id)
    professor_to_be_assigned = Professor.all.map  do |professor|
      case professor.status
      when "active"
        [professor.id, professor.id]
      when "partial"
        [professor.id]
      when "license"
        []
      end
    end
    professor_to_be_assigned = professor_to_be_assigned.flatten
    professors_already_assigned = Offering.where(semester: Date.new(2016,3)).where("professor_id IS NOT NULL").pluck(:professor_id)
    professors_already_assigned.each do |x|
      professor_to_be_assigned.delete_at(professor_to_be_assigned.find_index(x))
    end
    result = {offerings: offering_to_be_assigned, professors: professor_to_be_assigned}
    result
  end

  def get_first_priority_assignable(offerings)
    offerings.select do |offering|
      get_info_copy(offering)[:first_choice_of].length == 1
    end
  end

  def get_second_priority_assignable(offerings)
    offerings.select do |offering|
      get_info_copy(offering)[:first_choice_of].length == 0 && get_info_copy(offering)[:second_choice_of].length == 1
    end
  end

  def get_third_priority_assignable(offerings)
    offerings.select do |offering|
      get_info_copy(offering)[:first_choice_of].length == 0 && 
      get_info_copy(offering)[:second_choice_of].length == 0 && 
      get_info_copy(offering)[:third_choice_of].length == 1 
    end
  end

  def remove_preferences_from_unavailable_professor
    all_professors = Professor.all.pluck(:id)
    available = get_professors_and_offerings_for_assigning[:professors]
    unavailable = all_professors - available
    unavailable.each do |prof_id|
      Professor.find(prof_id).copyprefs.destroy_all
    end
  end

  def schedule_conflict?(schedule1,schedule2)
    schedule1.gsub!(/[67]/,'z')
    schedule2.gsub!(/[67]/,'z')
    arr1 = []
    i = 0
    (schedule1.length / 2).times do
      arr1 << schedule1.slice(i,2)
      i += 2
    end
    arr2 = []
    j = 0
    (schedule2.length / 2).times do
      arr2 << schedule2.slice(j,2)
      j += 2
    end
    arr1 & arr2 != [] 
  end


  #this method will be responsible for doing the asignment 
  def do_magic
    Copypref.populate_to_copyprefs
    remove_preferences_from_unavailable_professor
    while (get_first_priority_assignable(get_professors_and_offerings_for_assigning[:offerings]) != [] ||
          get_second_priority_assignable(get_professors_and_offerings_for_assigning[:offerings]) != [] ||
          get_third_priority_assignable(get_professors_and_offerings_for_assigning[:offerings]) != [])
      remove_preferences_from_unavailable_professor
      easy_first = get_first_priority_assignable(get_professors_and_offerings_for_assigning[:offerings])
      easy_first.each do |offering_id|
        offering = Offering.find(offering_id)
        professor_id = Professor.find_by(name: get_info_copy(offering_id)[:first_choice_of][0]).id
        if Professor.find(professor_id).offerings.first
          if schedule_conflict?(Professor.find(professor_id).offerings.first.schedule,offering.schedule)
            if (offering.course.kind == 'major')
              x = Professor.find(professor_id).copyprefs.first
              x.first_major = nil
              x.save
            else
              x = Professor.find(professor_id).copyprefs.first
              x.first_service = nil
              x.save
            end
          else
            offering.professor_id = professor_id
            offering.save         
          end
        else
          offering.professor_id = professor_id
          offering.save  
        end        
      end
      remove_preferences_from_unavailable_professor
      easy_second = get_second_priority_assignable(get_professors_and_offerings_for_assigning[:offerings])
      easy_second.each do |offering_id|
        offering = Offering.find(offering_id)
        professor_id = Professor.find_by(name: get_info_copy(offering_id)[:second_choice_of][0]).id
        if Professor.find(professor_id).offerings.first
          if schedule_conflict?(Professor.find(professor_id).offerings.first.schedule,offering.schedule)
            if (offering.course.kind == 'major')
              x = Professor.find(professor_id).copyprefs.first
              x.second_major = nil
              x.save
            else
              x = Professor.find(professor_id).copyprefs.first
              x.second_service = nil
              x.save
            end
          else
            offering.professor_id = professor_id
            offering.save         
          end
        else
          offering.professor_id = professor_id
          offering.save  
        end        
      end
      remove_preferences_from_unavailable_professor
      easy_third = get_third_priority_assignable(get_professors_and_offerings_for_assigning[:offerings])
      easy_third.each do |offering_id|
        offering = Offering.find(offering_id)
        professor_id = Professor.find_by(name: get_info_copy(offering_id)[:third_choice_of][0]).id
        if Professor.find(professor_id).offerings.first
          if schedule_conflict?(Professor.find(professor_id).offerings.first.schedule,offering.schedule)
            if (offering.course.kind == 'major')
              x = Professor.find(professor_id).copyprefs.first
              x.third_major = nil
              x.save
            else
              x = Professor.find(professor_id).copyprefs.first
              x.third_service = nil
              x.save
            end
          else
            offering.professor_id = professor_id
            offering.save         
          end
        else
          offering.professor_id = professor_id
          offering.save  
        end        
      end
    end    
  end

end
