module ApplicationHelper

  
  #this method will be responsible for doing the asignment 
  def do_magic
    offering_to_be_assigned = Offering.all.pluck(:id)
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





  end

end
