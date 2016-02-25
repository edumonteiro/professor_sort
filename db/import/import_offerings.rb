# course_id: nil, letter: nil, schedule: nil, professor_id: nil, semester: nil
# a1  8   10    a monday
# a2  10  12    b tuesday
# a3  12  14    c wednesday
# a4  14  16    d thursday
# a5  16  18    e friday
# a6  18  20
# a7  19  21
# a8  21  23




aa = Offering.new()
aa.course_id = Course.find_by(name: "Categorical Data Analysis").id
aa.letter = "A"
aa.schedule = "a2c2"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Linear Regression Analysis").id
aa.letter = "A"
aa.schedule = "b1d1e1"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Time Series Analysis").id
aa.letter = "A"
aa.schedule = "a6c6"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Survival Analysis").id
aa.letter = "A"
aa.schedule = "a1c1"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Aplications of Statistics 1").id
aa.letter = "A"
aa.schedule = "b1d1"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Aplications of Statistics 1").id
aa.letter = "B"
aa.schedule = "a4c4"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Biostatistics").id
aa.letter = "A"
aa.schedule = "b1d1"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Biostatistics").id
aa.letter = "B"
aa.schedule = "b1d1"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Biostatistics").id
aa.letter = "C"
aa.schedule = "b4e4"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Computations in Statistics 1").id
aa.letter = "A"
aa.schedule = "e2"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Computations in Statistics 1").id
aa.letter = "B"
aa.schedule = "b5"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Computations in Statistics 2").id
aa.letter = "A"
aa.schedule = "b2d2"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Computations in Statistics 2").id
aa.letter = "B"
aa.schedule = "b4d4"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Design and Analysis of Experiments").id
aa.letter = "A"
aa.schedule = "a5c5e5"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Demography").id
aa.letter = "A"
aa.schedule = "a5c5"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Applied Statistics").id
aa.letter = "A"
aa.schedule = "a7c7e7"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Applied Statistics").id
aa.letter = "B"
aa.schedule = "a1c1e1"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Applied Statistics").id
aa.letter = "C"
aa.schedule = "a1c1e1"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Applied Statistics").id
aa.letter = "D"
aa.schedule = "a2c2e2"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Applied Statistics").id
aa.letter = "E"
aa.schedule = "a7c7e7"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Applied Statistics").id
aa.letter = "F"
aa.schedule = "a1c1e1"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Applied Statistics").id
aa.letter = "G"
aa.schedule = "a2c2e2"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Applied Statistics").id
aa.letter = "H"
aa.schedule = "a4c4e4"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Applied Statistics").id
aa.letter = "I"
aa.schedule = "a8c8e8"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Applied Statistics").id
aa.letter = "J"
aa.schedule = "a2c2e2"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Applied Statistics").id
aa.letter = "K"
aa.schedule = "a4c4e4"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Applied Statistics").id
aa.letter = "L"
aa.schedule = "a7c7e7"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Applied Statistics").id
aa.letter = "M"
aa.schedule = "a8c8e8"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Applied Statistics").id
aa.letter = "N"
aa.schedule = "a5c5e5"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Applied Statistics").id
aa.letter = "O"
aa.schedule = "a5c5e5"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Computational Statistics").id
aa.letter = "A"
aa.schedule = "a4c4"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Exploratory Statistics").id
aa.letter = "A"
aa.schedule = "a2c2"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Statistical Inference").id
aa.letter = "A"
aa.schedule = "b1d1e1"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Introduction to Probability").id
aa.letter = "A"
aa.schedule = "a1c1"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Introduction to Probability").id
aa.letter = "B"
aa.schedule = "a1c1"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Statistical Methods 1").id
aa.letter = "A"
aa.schedule = "a1c1"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Statistical Methods 2").id
aa.letter = "A"
aa.schedule = "a4c4"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Operations Research").id
aa.letter = "A"
aa.schedule = "b4d4e4"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Probability and Statistics").id
aa.letter = "A"
aa.schedule = "a5c5e5"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Probability and Statistics").id
aa.letter = "B"
aa.schedule = "a2c2e2"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Probability and Statistics").id
aa.letter = "C"
aa.schedule = "a7c7e7"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Probability and Statistics").id
aa.letter = "D"
aa.schedule = "a4c4e4"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Probability and Statistics").id
aa.letter = "E"
aa.schedule = "a4c4e4"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Probability and Statistics").id
aa.letter = "F"
aa.schedule = "a5c5e5"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Probability and Statistics").id
aa.letter = "G"
aa.schedule = "a7c7e7"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Probability and Statistics").id
aa.letter = "H"
aa.schedule = "a4c4e4"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Probability and Statistics").id
aa.letter = "I"
aa.schedule = "a2c2e2"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Probability and Statistics").id
aa.letter = "J"
aa.schedule = "a1c1e1"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Probability and Statistics").id
aa.letter = "K"
aa.schedule = "a7c7e7"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Probability and Statistics").id
aa.letter = "L"
aa.schedule = "a1c1e1"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Survey Tecniques").id
aa.letter = "A"
aa.schedule = "b2d2e2"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Topics in Statistics 1").id
aa.letter = "A"
aa.schedule = "b1d1"
aa.semester = Date.new(2016,3)
aa.save

aa = Offering.new()
aa.course_id = Course.find_by(name: "Topics in Statistics 2").id
aa.letter = "A"
aa.schedule = "b4d4"
aa.semester = Date.new(2016,3)
aa.save
