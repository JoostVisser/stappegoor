class FormMailer < ApplicationMailer
  def sample_email
    @name = "Joost"
    @email = "joost.visser1@gmail.com"
    # email = mail to: @email, from: 'example@email.com' subject: 'Sample Email'
    email = mail from: 'sender@email.com', to: 'joost.visser1@gmail.com', subject: 'this is an email'
  end
end
