require 'faker'
i = 0
28.times do 
  
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

professor = Professor.new
professor.name = "super"
professor.email = "super"
professor.kind = "admin"
professor.status = "license"
professor.save

aa = Ourconfig.new
aa.name = "super_user_id"
aa.value = professor.id
aa.save