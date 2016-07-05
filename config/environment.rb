# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Setting up sendgrid as mailer
ActionMailer::Base.smtp_settings = {
    :user_name => Rails.application.secrets.sendgrid_username,
    :password => Rails.application.secrets.sendgrid_password,
    :domain => 'joostvisser.me',
    :address => 'smtp.sendgrid.net',
    :port => 587,
    :authentication => :plain,
    :enable_starttls_auto => true
  }

# Initialize the Rails application.
Rails.application.initialize!
