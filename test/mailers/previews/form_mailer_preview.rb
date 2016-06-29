# Preview all emails at http://localhost:3000/rails/mailers/form_mailer
class FormMailerPreview < ActionMailer::Preview
  def sample_mail_preview
    FormMailer.sample_email
  end
end