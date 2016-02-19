class Admin::Dashboard < ActionMailer::Base

  default from: "ed@university.com"

  def notify_all(professor)
    @professor = professor
    mail(to: @professor.email, subject: "#{@professor.name}, Time to fill your preferences")
  end

end
