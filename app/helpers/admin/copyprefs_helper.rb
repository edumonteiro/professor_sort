module Admin::CopyprefsHelper
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
end
