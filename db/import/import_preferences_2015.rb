professors_ids = Professor.all.pluck(:id)
service_offering_ids = []
major_offering_ids = []
Offering.where(semester: Date.new(2015,3)).each do |offering|
  if offering.course.kind == "major"
    major_offering_ids.push(offering.id)
  else
    service_offering_ids.push(offering.id)  
  end
end

professors_ids.each do |prof_id|
  preference = Preference.new
  preference.professor_id = prof_id
  preference.first_major = major_offering_ids.sample
  preference.second_major = major_offering_ids.sample
  preference.third_major = major_offering_ids.sample
  preference.first_service = service_offering_ids.sample
  preference.second_service = service_offering_ids.sample
  preference.third_service = service_offering_ids.sample
  preference.semester = Date.new(2015,3)
  preference.save
end

professors_ids = []
Professor.all.each do |professor|
  professors_ids.push(professor.id)
end
service_offering_ids = []
major_offering_ids = []
Offering.where(semester: Date.new(2015,8)).each do |offering|
  if offering.course.kind == "major"
    major_offering_ids.push(offering.id)
  else
    service_offering_ids.push(offering.id)  
  end
end

professors_ids.each do |prof_id|
  preference = Preference.new
  preference.professor_id = prof_id
  preference.first_major = major_offering_ids.sample
  preference.second_major = major_offering_ids.sample
  preference.third_major = major_offering_ids.sample
  preference.first_service = service_offering_ids.sample
  preference.second_service = service_offering_ids.sample
  preference.third_service = service_offering_ids.sample
  preference.semester = Date.new(2015,8)
  preference.save
end



