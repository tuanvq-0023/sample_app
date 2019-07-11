class ApplicationMailer < ActionMailer::Base
  default from: ENV["SMTP_MAIL_USERNAME"]
  layout "mailer"
end
