namespace :email do
  task try_send: :environment do
    NewUserMailer.new_user_email.deliver_now
  end
end
