professors_ids = []
Professor.all.each do |professor|
  professors_ids.push(professor.id)
end

def separate_major_service(date)
  service_offering_ids = []
  major_offering_ids = []
  Offering.where(semester: date).each do |offering|
    if offering.course.kind == "major"
      major_offering_ids.push(offering.id)
    else
      service_offering_ids.push(offering.id)  
    end
  end
  {major: major_offering_ids, service: service_offering_ids}
end


professors_ids.each do |prof_id|
  major_offering_ids = separate_major_service(Date.new(2016,3))[:major].sample(separate_major_service(Date.new(2016,3))[:major].length)
  service_offering_ids = separate_major_service(Date.new(2016,3))[:service].sample(separate_major_service(Date.new(2016,3))[:service].length)
  preference = Preference.new
  preference.professor_id = prof_id
  preference.first_major = major_offering_ids.shift
  preference.second_major = major_offering_ids.shift
  preference.third_major = major_offering_ids.shift
  preference.first_service = service_offering_ids.shift
  preference.second_service = service_offering_ids.shift
  preference.third_service = service_offering_ids.shift
  preference.semester = Date.new(2016,3)
  preference.save
end

professors_ids.each do |prof_id|
  major_offering_ids = separate_major_service(Date.new(2015,8))[:major].sample(separate_major_service(Date.new(2015,8))[:major].length)
  service_offering_ids = separate_major_service(Date.new(2015,8))[:service].sample(separate_major_service(Date.new(2015,8))[:service].length)
  preference = Preference.new
  preference.professor_id = prof_id
  preference.first_major = major_offering_ids.shift
  preference.second_major = major_offering_ids.shift
  preference.third_major = major_offering_ids.shift
  preference.first_service = service_offering_ids.shift
  preference.second_service = service_offering_ids.shift
  preference.third_service = service_offering_ids.shift
  preference.semester = Date.new(2015,8)
  preference.save
end

professors_ids.each do |prof_id|
  major_offering_ids = separate_major_service(Date.new(2015,3))[:major].sample(separate_major_service(Date.new(2015,3))[:major].length)
  service_offering_ids = separate_major_service(Date.new(2015,3))[:service].sample(separate_major_service(Date.new(2015,3))[:service].length)
  preference = Preference.new
  preference.professor_id = prof_id
  preference.first_major = major_offering_ids.shift
  preference.second_major = major_offering_ids.shift
  preference.third_major = major_offering_ids.shift
  preference.first_service = service_offering_ids.shift
  preference.second_service = service_offering_ids.shift
  preference.third_service = service_offering_ids.shift
  preference.semester = Date.new(2015,3)
  preference.save
end

