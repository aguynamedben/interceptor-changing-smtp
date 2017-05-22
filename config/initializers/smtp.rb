unless Rails.env.test?
  unless ENV["SMTP_ADDRESS"] &&
         ENV["SMTP_DOMAIN"] &&
         ENV["SMTP_PORT"] &&
         ENV["SMTP_USER_NAME"] &&
         ENV["SMTP_PASSWORD"]
    raise "Please ensure ENV variables for all SMTP settings are configured: SMTP_ADDRESS, SMTP_PORT, SMTP_USER_NAME, SMTP_PASSWORD"
  end

  if ENV["SMTP_TLS"] == "1"
    tls = true
  else
    tls = false
  end

  Rails.application.configure do
    config.action_mailer.smtp_settings = {
      address: ENV["SMTP_ADDRESS"],
      domain: ENV["SMTP_DOMAIN"],
      port: ENV["SMTP_PORT"],
      user_name: ENV["SMTP_USER_NAME"],
      password: ENV["SMTP_PASSWORD"],
      authentication: :plain,
      tls: tls
    }
  end
end
