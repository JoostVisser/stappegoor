class FormMailer < ApplicationMailer
  def sample_email
    @name = "Joost"
    @email = "joost.visser1@gmail.com"
    mail(to: @email, subject: 'Sample Email')
  end
end
