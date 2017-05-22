class NewUserMailer < ApplicationMailer
  def new_user_email
    subject = "[Signup] Some new user signed up"
    mail(to: "to@example.com", subject: subject)
  end
end
