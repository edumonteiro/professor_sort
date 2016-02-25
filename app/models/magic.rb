class Magic
  
  class << self

    def current_semester
      current_semester = nil
      semester = Ourconfig.find_by(name: "semester").value.split("/")
      case semester[0]
      when "0"
        current_semester = Date.new(semester[1].to_i,1)
      when "1"
        current_semester = Date.new(semester[1].to_i,3)
      when "2"
        current_semester = Date.new(semester[1].to_i,8)
      end
      current_semester        
    end

    def past_semester
      case current_semester.month
      when 1
        past_semester = Date.new(current_semester.year-1,8)
      when 3
        past_semester = Date.new(current_semester.year-1,8)
      when 8
        past_semester = Date.new(current_semester.year,3)      
      end
      past_semester
    end

    def twoago_semester
      case past_semester.month
      when 1
        twoago_semester = Date.new(past_semester.year-1,8)
      when 3
        twoago_semester = Date.new(past_semester.year-1,8)
      when 8
        twoago_semester = Date.new(past_semester.year,3)      
      end
      twoago_semester
    end

    def get_info_copy(offering_id)
        offering = Offering.find(offering_id)
        name = offering.course.name
        if offering.course.kind == "major"
          pref1 = Copypref.where(first_major: offering_id)
          prof_first_choice = []
          pref1.each do |copypref|
            prof_first_choice.push(copypref.professor.name)
          end
          prof_second_choice = []
          pref2 = Copypref.where(second_major: offering_id)
          pref2.each do |copypref|
            prof_second_choice.push(copypref.professor.name)
          end
          prof_third_choice = []
          pref3 = Copypref.where(third_major: offering_id)
          pref3.each do |copypref|
            prof_third_choice.push(copypref.professor.name)
          end      
        else
          pref1 = Copypref.where(first_service: offering_id)
          prof_first_choice = []
          pref1.each do |copypref|
            prof_first_choice.push(copypref.professor.name)
          end
          prof_second_choice = []
          pref2 = Copypref.where(second_service: offering_id)
          pref2.each do |copypref|
            prof_second_choice.push(copypref.professor.name)
          end
          prof_third_choice = []
          pref3 = Copypref.where(third_service: offering_id)


          pref3.each do |copypref|
            prof_third_choice.push(copypref.professor.name)
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
        result
    end
  
    #Method to create a hash with array of available professors and offerings to be assigned
    #The professor id apears in the array the nuber of classes he is available for teaching
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


    def tought_last(professor_id,course_id)
      Course.find(course_id).lectures.where(semester: past_semester).pluck(:professor_id).include?(professor_id)
    end

    def tought_onebefore_last(professor_id,course_id)
      Course.find(course_id).lectures.where(semester: twoago_semester).pluck(:professor_id).include?(professor_id)
    end

    def was_prefered_and_tought_last_by(offering_id)
      course_id = Offering.find(offering_id).course_id
      prefered_by = get_info_copy(offering_id).values_at(:first_choice_of, :second_choice_of, :third_choice_of).flatten
      prefered_by.each do |professor|
        prof_id = Professor.find_by(name: professor).id
        if tought_last(prof_id,course_id) #here I just check if he taught last, maybe should avoid form teaching twice
          return prof_id      
        end
      end
      nil
    end

    def was_prefered_now_and_previously_by(offering_id)
      course_id = Offering.find(offering_id).course
      professors_ids = []
      offerings_ids = Course.find(course_id).offerings.pluck(:id)
      offerings_ids.delete(offering_id)
      offerings_ids.each do |id_offering|
        professors_ids.push(Preference.where(first_major: id_offering).pluck(:professor_id))
        professors_ids.push(Preference.where(second_major: id_offering).pluck(:professor_id))
        professors_ids.push(Preference.where(third_major: id_offering).pluck(:professor_id))
      end
      professors_ids = professors_ids.flatten
      prefered_by = get_info_copy(offering_id).values_at(:first_choice_of, :second_choice_of, :third_choice_of).flatten
      prefered_by.each do |professor|
        prof_id = Professor.find_by(name: professor).id
        if professors_ids.include?(prof_id)
          return prof_id      
        end
      end
      nil
    end

    #this method will be responsible for doing the asignment 
    def do_magic
      Copypref.populate_to_copyprefs
      remove_preferences_from_unavailable_professor
      #First Round will keep looping and assigning cases with on ties on the highest preferences available
      while (get_first_priority_assignable(get_professors_and_offerings_for_assigning[:offerings]) != [] ||
            get_second_priority_assignable(get_professors_and_offerings_for_assigning[:offerings]) != [] ||
            get_third_priority_assignable(get_professors_and_offerings_for_assigning[:offerings]) != [])
        remove_preferences_from_unavailable_professor
        #Firstly the cases with no ties on the first preference
        easy_first = get_first_priority_assignable(get_professors_and_offerings_for_assigning[:offerings])
        easy_first.each do |offering_id|
          offering = Offering.find(offering_id)
          professor_id = Professor.find_by(name: get_info_copy(offering_id)[:first_choice_of][0]).id
          if get_professors_and_offerings_for_assigning[:professors].include?(professor_id)
            if Professor.find(professor_id).offerings.where(semester: current_semester).first
              if schedule_conflict?(Professor.find(professor_id).offerings.where(semester: current_semester).first.schedule,offering.schedule)
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
        end
        remove_preferences_from_unavailable_professor
        easy_second = get_second_priority_assignable(get_professors_and_offerings_for_assigning[:offerings])
        easy_second.each do |offering_id|
          offering = Offering.find(offering_id)
          professor_id = Professor.find_by(name: get_info_copy(offering_id)[:second_choice_of][0]).id
          if get_professors_and_offerings_for_assigning[:professors].include?(professor_id)
            if Professor.find(professor_id).offerings.where(semester: current_semester).first
              if schedule_conflict?(Professor.find(professor_id).offerings.where(semester: current_semester).first.schedule,offering.schedule)
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
        end
        remove_preferences_from_unavailable_professor
        easy_third = get_third_priority_assignable(get_professors_and_offerings_for_assigning[:offerings])
        easy_third.each do |offering_id|
          offering = Offering.find(offering_id)
          professor_id = Professor.find_by(name: get_info_copy(offering_id)[:third_choice_of][0]).id
          if get_professors_and_offerings_for_assigning[:professors].include?(professor_id)
            if Professor.find(professor_id).offerings.where(semester: current_semester).first
              if schedule_conflict?(Professor.find(professor_id).offerings.where(semester: current_semester).first.schedule,offering.schedule)
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
      ###Second round, solving ties by past lectures
      get_professors_and_offerings_for_assigning[:offerings].each do |offering|
        professor_id = was_prefered_and_tought_last_by(offering)
        if professor_id && get_professors_and_offerings_for_assigning[:professors].include?(professor_id)
          if Professor.find(professor_id).offerings.where(semester: current_semester).first
            unless schedule_conflict?(Professor.find(professor_id).offerings.where(semester: current_semester).first.schedule,Offering.find(offering).schedule)
              assignable = Offering.find(offering)
              assignable.professor_id = professor_id
              assignable.save
              ##If add on other rules should take care of removing professor?          
            end
          end
        end
      end
      ###Third round, solving ties by past preferences
      get_professors_and_offerings_for_assigning[:offerings].each do |offering|
        professor_id = was_prefered_and_tought_last_by(offering)
        if professor_id && get_professors_and_offerings_for_assigning[:professors].include?(professor_id)
          if Professor.find(professor_id).offerings.where(semester: current_semester).first
            unless schedule_conflict?(Professor.find(professor_id).offerings.where(semester: current_semester).first.schedule,Offering.find(offering).schedule)
              assignable = Offering.find(offering)
              assignable.professor_id = professor_id
              assignable.save
              ##If add on other rules should take care of removing professor?          
            end
          end
        end
      end
    #end of the method  
    end
  #end of the self assignment
  end

#end of the class
end