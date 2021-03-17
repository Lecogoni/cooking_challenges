class InvitesController < ApplicationController
  before_action :set_invite, only: %i[ show edit update destroy ]
  after_action :transfer_invite_to_user, only: %i[ update ]

  # GET /invites or /invites.json
  def index
    @invites = Invite.all
  end

  # GET /invites/1 or /invites/1.json
  def show
  end

  # GET /invites/new
  def new
    @invite = Invite.new
  end

  # GET /invites/1/edit
  def edit
  end

  # POST /invites or /invites.json
  def create
    @invite = Invite.new(invite_params)

    respond_to do |format|
      if @invite.save
        format.html { redirect_to @invite, notice: "Invite was successfully created." }
        format.json { render :show, status: :created, location: @invite }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @invite.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT
  def update

      # get challenge_id for the mentionned invited challenge
      @challenge_id = params[:challenge]
     
      if @invite.update(invite_params)
        flash.now[:notice] = 'invitation envoyé!'
      else
        flash.now[:alert] = 'Error !'
      end

  end

  # DELETE /invites/1 or /invites/1.json
  def destroy
    @invite.destroy
    respond_to do |format|
      format.html { redirect_to invites_url, notice: "Invite was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def transfer_invite_to_user
    # get info on invinted user
    @inviting = Invite.find_by(email: @invite.email)
    # create a new user from the invited user
    @invinting_user = User.create(email: @inviting.email, password: "cooking" )

    # Create an Event link to the mentionned challenge and invinted user
    @new_event = Event.create(user_id: @invinting_user.id, challenge_id: @challenge_id )

    # generating a devise reset password
    raw, hashed = Devise.token_generator.generate(User, :reset_password_token)

    user = User.find_by(email: @invinting_user.email)
    user.reset_password_token = hashed
    user.reset_password_sent_at = Time.now.utc
    user.save

    # send invitation email to new user
    UserMailer.invitation_email(user, raw).deliver_now
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invite
      @invite = Invite.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def invite_params
      params.require(:invite).permit(:email)
    end
end
