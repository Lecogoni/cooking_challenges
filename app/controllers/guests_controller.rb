class GuestsController < ApplicationController
  before_action :set_guest, only: %i[ show edit update destroy ]

  # GET /guests or /guests.json
  def index
    @guests = Guest.all
  end

  # GET /guests/1 or /guests/1.json
  def show
  end

  # GET /guests/new
  def new
    @guest = Guest.new
  end

  # GET /guests/1/edit
  def edit
  end

  # POST /guests or /guests.json
  def create
    @guest = Guest.new(guest_params)

    respond_to do |format|
      if @guest.save
        flash[:notice] = "Création d'un invité."
        format.html { redirect_to @guest }
        format.json { render :show, status: :created, location: @guest }
      else
        flash.now[:warning] = "Echec :" + @guest.errors.full_messages.join(" ")
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /guests/1 or /guests/1.json
  def update

    @this_challenge = @guest.challenge.theme_choice

    # get challenge_id for the mentionned guest challenge
    @challenge_id = params[:challenge]
    @challenge = Challenge.find(@challenge_id)

    if @guest.update(guest_params)
      if User.exists?(email: @guest.email)
        # send invitation email to existing user
        user = User.find_by(email: @guest.email)

        # Create an Event link to the mentionned challenge and  user
        @inviting = User.find_by(email: @guest.email)
        @new_event = Event.create(user_id: @inviting.id, challenge_id: @challenge_id )
        
        # fetch recipe from area or from category on API and save it according to user choice --> to user
        if @challenge.meal_category == nil || @challenge.meal_category == ""
          fetch_recipe_from_area(@challenge.meal_area, @new_event)
        elsif @challenge.meal_area == nil || @challenge.meal_area == ""
          fetch_recipe(@challenge.meal_category, @new_event)
        end

        UserMailer.invitation_email(user, current_user).deliver_now
      else
        flash.now[:notice] = 'Invitation envoyé !'
        transfer_guest_to_user()
      end
    else
      flash.now[:alert] = 'Erreur !'
    end

  end

  # DELETE /guests/1 or /guests/1.json
  def destroy
    @guest.destroy
    respond_to do |format|
      flash[:success] = "L'invité a été détruit avec succès. (cf traduction google du message généré automatiquement par rails... Il n'y aurait pas un peu de sadisme là dedans ?"
      format.html { redirect_to guests_url }
      format.json { head :no_content }
    end
  end


  def transfer_guest_to_user
    # get info on invinted user
    @inviting = Guest.find_by(email: @guest.email)
    # create a new user from the invited user
    @invinting_user = User.create(username: @inviting.username, email: @inviting.email, password: "cooking" )

    # Create an Event link to the mentionned challenge and invinted user
    @new_event = Event.create(user_id: @invinting_user.id, challenge_id: @challenge_id )

    @challenge = Challenge.find(params[:challenge])

    puts "--------------------------------------@@@@@@@----------------------------------------------------------------------"
    puts @new_event
    puts "----------------------------------------@@@@@@--------------------------------------------------------------------"
    puts "--------------------------------------@@@@@----------------------------------------------------------------------"
    puts "---------------------------------------@@@@@@@---------------------------------------------------------------------"
    puts "--------------------------------------@@@@@----------------------------------------------------------------------"
    puts current_user.id
    puts "---------------------------------------@@@@@@@---------------------------------------------------------------------"

    # fetch recipe from area or from category on API and save it according to user choice --> to guest
    if @challenge.meal_category == nil || @challenge.meal_category == ""
      fetch_recipe_from_area(@challenge.meal_area, @new_event)
      fetch_recipe_from_area(@challenge.meal_area, current_user)
    elsif @challenge.meal_area == nil || @challenge.meal_area == ""
     fetch_recipe(@challenge.meal_category, @new_event)
     fetch_recipe(@challenge.meal_category, current_user)

    end
    
    # generating a devise reset password
    raw, hashed = Devise.token_generator.generate(User, :reset_password_token)

    user = User.find_by(email: @invinting_user.email)
    user.reset_password_token = hashed
    user.reset_password_sent_at = Time.now.utc
    user.save

    # send invitation email to new user
    UserMailer.invitation_email_new_user(user, raw, current_user).deliver_now
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guest
      @guest = Guest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def guest_params
      params.require(:guest).permit(:email, :username)
    end
end
