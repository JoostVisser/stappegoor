# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Setting up sendgrid as mailer
ActionMailer::Base.smtp_settings = {
    :user_name => 'rackyl',
    :password => 'ImThZlch1-Se',
    :domain => 'joostvisser.me',
    :address => 'smtp.sendgrid.net',
    :port => 587,
    :authentication => :plain,
    :enable_starttls_auto => true
  }

# Initialize the Rails application.
Rails.application.initialize!
