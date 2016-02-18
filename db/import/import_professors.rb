require 'faker'
i = 0
30.times do 
  
  professor = Professor.new
  professor.name = Faker::Name.name 
  professor.password = "1234"
  professor.email = ["test",i].join("")
  professor.kind = "professor"
  professor.status = "active"
  professor.save
  i += 1
end

professor = Professor.new
professor.name = Faker::Name.name 
professor.password = "1234"
professor.email = "admin"
professor.kind = "admin"
professor.status = "active"
professor.save