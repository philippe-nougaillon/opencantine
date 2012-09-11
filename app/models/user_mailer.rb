# encoding: utf-8

class UserMailer < ActionMailer::Base
  default :from => "contact@opencantine.net"  
  
  def registration_confirmation(user)  
    mail(:to => user.email, :subject => "Registered")  
  end  

  def send_password(famille)
	@famille = famille
	mail(:subject => 'Pour consulter votre compte', :recipients => famille.email, :sent_on => Time.now)
  end

  def send_invoice(ville, famille, facture)
	@ville = ville
	@famille = famille
	@facture = facture
    attachments["Facture #{@facture.ref}.pdf"] = File.read("#{Rails.root}/pdfs/#{facture.id}.pdf")
	mail(:subject => "#{@ville.nom} - Facture périscolaire", :to => @famille.email, :cc => @ville.email)
  end


  def send_login(username,ip)
    subject    "#{username} s'est connecté à openCantine.fr"
    recipients "philippe@capcod.com"
    sent_on    Time.now
    body       "#{username} s'est connecté depuis : #{ip}"
  end

  def send_logout(username,ip)
    subject    "#{username} s'est déconnecté de openCantine.fr"
    recipients "philippe@capcod.com"
    sent_on    Time.now
    body       "#{username} s'est déconnecté depuis : #{ip}"
  end

  def send_info(email)
    subject    "openCantine.fr - Vos identifiants de connexion"
    recipients  email
    sent_on    Time.now
    body       "Un compte #{email} a bien été créé. Utilisez votre email comme identifiant et mot de passe pour vous connecter. Vous pouvez modifier votre mot de passe à tout moment."
  end
end
