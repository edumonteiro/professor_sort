require 'csv'

data = CSV.read("./db/import/courses.csv")
header = ["name","credits","kind"]
sym_head = header.map { |head| head.to_sym}

courses = []
data.each do |row|
  courses << Hash[sym_head.zip(row)]
end
courses.each do |course|
  Course.create(course)
end