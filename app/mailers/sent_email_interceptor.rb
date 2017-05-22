class SentEmailInterceptor
  def self.delivering_email(message)
    Rails.logger.info("We're sending a message to: #{message.to}")
    Rails.logger.info("We're using the SMTP settings: #{Rails.application.config.action_mailer.smtp_settings}")
  end
end
