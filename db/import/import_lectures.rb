prof_ids = Professor.all.pluck(:id)
prof_ids = prof_ids.sample(prof_ids.length)
prof_ids = prof_ids.concat(prof_ids.sample(prof_ids.length))
prof_ids
offering2015 = Offering.where(semester: Date.new(2015,8))
offering2015.each do |offering|
  lecture = Lecture.new
  lecture.course_id = offering.course_id
  lecture.schedule = offering.schedule
  lecture.semester = offering.semester
  lecture.professor_id = prof_ids.pop
  lecture.save
end

prof_ids = Professor.all.pluck(:id)
prof_ids = prof_ids.sample(prof_ids.length)
prof_ids = prof_ids.concat(prof_ids.sample(prof_ids.length))
prof_ids
offering2015 = Offering.where(semester: Date.new(2015,3))
offering2015.each do |offering|
  lecture = Lecture.new
  lecture.course_id = offering.course_id
  lecture.schedule = offering.schedule
  lecture.semester = offering.semester
  lecture.professor_id = prof_ids.pop
  lecture.save
end



# prof_ids = Professor.all.pluck(:id)
# prof_ids = prof_ids.sample(prof_ids.length)
# prof_ids = prof_ids.concat(prof_ids.sample(prof_ids.length))
# prof_ids
# offering2015 = Offering.where(semester: Date.new(2016,3))
# offering2015.each do |offering|
#   lecture = Lecture.new
#   lecture.course_id = offering.course_id
#   lecture.schedule = offering.schedule
#   lecture.semester = offering.semester
#   lecture.professor_id = prof_ids.pop
#   lecture.save
# end