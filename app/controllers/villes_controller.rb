# encoding: utf-8

class VillesController < ApplicationController

  layout "standard"

  def nouveau_compte
    @ville = Ville.new
  end	

  # POST /villes
  def nouveau_compte_create
    @ville = Ville.new(params[:ville])
    @ville.FacturationModuleName = "01-Standard.rb"
    @ville.newsletter = true

    if @ville.save
		u = User.new
		u.mairie_id = @ville.id
		    u.username = @ville.email
		    u.password_hash = @ville.email
		u.lastconnection = Time.now
		    u.lastchange = Time.now
		    u.readwrite = true
		u.save

	 	prochain = FactureChrono.new
		    prochain.mairie_id = @ville.id
		prochain.prochain = 1
		prochain.save

		tarif = Tarif.new
		tarif.type_id = 1
		tarif.mairie_id = @ville.id
		tarif.memo = "Tarif Général"
		tarif.RepasP = 1.00
		tarif.GarderieAMP = 1.00
		tarif.GarderiePMP = 1.00
		tarif.CentreAMP = 1.00
		tarif.CentrePMP = 1.00
		tarif.CentreAMPMP = 2.00
		tarif.Etude = 1.00
		tarif.save
	
		vacance = Vacance.new
		vacance.mairie_id = @ville.id
		vacance.nom = "NOEL"
		vacance.debut = "20.12.2010"
		vacance.fin = "03.01.2011"
		vacance.save

		classe = Classroom.new
		classe.mairie_id = @ville.id
		classe.nom = "CP"
		classe.referant = "La maîtresse"
		classe.save

		famille = Famille.new
		famille.mairie_id = @ville.id
		famille.nom = "Famille PETIT pour test"
		famille.adresse = "1, rue des petits champs"
		famille.cp = "93220"
		famille.ville = "GAGNY"
		famille.phone = "01.43.32.82.18"
		famille.save

		e = Enfant.new
		e.famille_id = famille.id
		e.prenom = "Nicolas"
		e.dateNaissance = "01/01/2003"
		e.age = 7
		e.classe = classe.id
		e.save
		
		pr = Prestation.new
		pr.enfant_id = e.id
		pr.date = Time.now
		pr.repas = "1"
		pr.save

		# envoyer un mail au nouvel utilisateur
		UserMailer.send_info(@ville.email).deliver

		#ouverture de la session
		session[:user] = u.id
		session[:user_readwrite] = u.readwrite
		session[:mairie] = u.mairie_id
		redirect_to :action => "bienvenue", :controller => "admin"
		flash[:notice] = 'Bienvenue ! Vous êtes maintenant connecté à openCantine.'
	    UserMailer.send_login(u.username, request.env["HTTP_X_FORWARDED_FOR"] || request.remote_addr).deliver
    else
        render :action => "nouveau_compte" 
    end
  end
  
  # GET /villes/1/edit
  def edit
    @ville = Ville.find(session[:mairie])
  end

  def show
    redirect_to :controller => 'admin', :action => 'setup'
  end

  # PUT /villes/1
  # PUT /villes/1.xml
  def update
    @ville = Ville.find(session[:mairie])

    respond_to do |format|
      if @ville.update_attributes(params[:ville])
        flash[:notice] = 'Modifications validées'
        format.html { redirect_to(:controller => 'admin', :action => 'setup') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ville.errors, :status => :unprocessable_entity }
      end
    end
  end

end
