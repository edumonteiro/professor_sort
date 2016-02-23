module ApplicationHelper

  

  def get_professors_and_offerings_for_assigning
    offering_to_be_assigned = Offering.where(semester: current_semester).pluck(:id)
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
    result = {offerings: offering_to_be_assigned, professors: professor_to_be_assigned}
    result
  end

  def get_first_priority_assignable(offerings)
    offerings.select do |offering|
      get_info(offering)[:first_choice_of].length == 1
    end
  end

  def get_second_priority_assignable(offerings)
    offerings.select do |offering|
      get_info(offering)[:first_choice_of].length == 0 && get_info(offering)[:second_choice_of].length == 1
    end
  end

  def get_third_priority_assignable(offerings)
    offerings.select do |offering|
      get_info(offering)[:first_choice_of].length == 0 && 
      get_info(offering)[:second_choice_of].length == 0 && 
      get_info(offering)[:second_choice_of].length == 1 
    end
  end



  #this method will be responsible for doing the asignment 
  def do_magic
    easy = get_first_priority_assignable(get_professors_and_offerings_for_assigning[:offerings])
    easy.each do |offering_id|
      offering = Offering.find(offering_id)
      professor_id = Professor.find_by(name: get_info(offering_id)[:first_choice_of][0]).id
      offering.professor_id = professor_id
      offering.save
    end    
  end

end
