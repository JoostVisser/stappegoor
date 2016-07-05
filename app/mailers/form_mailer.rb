class FormMailer < ApplicationMailer
  def sample_email
    @name = "Joost"
    @sender_email = "joost.visser1@gmail.com"
    # email = mail to: @email, from: 'example@email.com' subject: 'Sample Email'
    email = mail from: 'info@horecatilburg.nl', to: @sender_email, subject: 'Bevestiging aanvraag kinderfeestje'
  end
end
