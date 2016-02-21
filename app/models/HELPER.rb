

def course_preferences_reporter
  result = []
  Course.where(kind: "major").each do |course|
    course.offerings.each do |offering|
      report = {}
      report[:course_name] = offering.course.name
      report[:letter] = offering.letter
      report[:semester] = offering.semester
      report[:first_choice_of] = Preference.where(first_major: offering.id).pluck(:professor_id)
      report[:second_choice_of] = Preference.where(second_major: offering.id).pluck(:professor_id)
      report[:third_choice_of] = Preference.where(third_major: offering.id).pluck(:professor_id)
      result << report
    end
  end
  result
end


def display_report(results)

  Course.where(kind: "major").each do |course|
    pp results.select {|hash| hash[:course_name] == course.name}
  end

end


aa = course_preferences_reporter
display_report(aa)

