class ContactMailer < ApplicationMailer

  def contact_mail(contact, member)
    @contact = contact
    mail to: member.email, bcc: ENV["ACTION_MAILER_ADMIN"], subject: "お問い合わせについて【自動送信】"
  end
end
