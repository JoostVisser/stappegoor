class FormMailer < ApplicationMailer
  def sample_email
    @name = "Joost"
    @email = "joost.visser1@gmail.com"
    email = mail to: @email, from: 'example@email.com' subject: 'Sample Email'
    return
  end
end
