class ChallengesController < ApplicationController
  before_action :set_challenge, only: %i[ show edit update destroy ]
  before_action :set_chal, only: %i[ upd ]

  # GET /challenges or /challenges.json
  def index
    @challenges = Challenge.all
  end

  # GET /challenges/1 or /challenges/1.json
  def show
  end

  # GET /challenges/new
  def new
    @challenge = Challenge.new
  end

  # GET /challenges/1/edit
  def edit
  end

  # POST /challenges or /challenges.json
  def create

    @challenge = Challenge.new(challenge_params)
  
    # stock the number of guest from params
    @num_guest = @challenge.numb_guest

    # stock the meal category
    @meal_category = @challenge.meal_category
    
    # stock the meal area
    @meal_area = @challenge.meal_area
  
    respond_to do |format|
      if @challenge.save

        # create the number of Guest with the id of the current challenge
        @num_guest.times do
        Guest.create(email: "", username: "", challenge_id: @challenge.id)
        end
        
        format.html { redirect_to edit_challenge_path(@challenge), notice: "Plus que quelques clic et ton challenge sera validé !" }
        format.json { render :show, status: :created, location: @challenge }


      else
        flash.now[:danger] = "Echec :" + @challenge.errors.full_messages.join(" ")
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /challenges/1 or /challenges/1.json
  def update

    # if @challenge.theme_choice == "area" && (@challenge.meal_area == "" || @challenge.meal_area == nil)
    #   respond_to do |format|
    #     format.html { redirect_to edit_challenge_path(@challenge.id), notice: "Vous devez choisir un pays" }
    #     format.json { render json: @challenge.errors, status: :unprocessable_entity }
    #   end
    # elsif @challenge.theme_choice == "Category" && (@challenge.meal_category == "" || @challenge.meal_category == nil)
    #   respond_to do |format|
    #     format.html { render :new, notice: "Vous devez spécifie la catégorie de souhaitée" }
    #     format.json { render json: @challenge.errors, status: :unprocessable_entity }
    #   end
    # end

    respond_to do |format|
      if @challenge.update(challenge_params)

        if Event.where(user_id: current_user.id, challenge_id: @challenge.id, role: "créateur", participation: "confirmed").count == 0
          # Associate on Event table the new challenge whit the current_user
          @owner_event = Event.create(user_id: current_user.id, challenge_id: @challenge.id, role: "créateur", participation: "confirmed")

          # call to associate a recipe
          if @challenge.meal_category == nil || @challenge.meal_category == ""
            fetch_recipe_from_area(@challenge.meal_area, @owner_event)
          elsif @challenge.meal_area == nil || @challenge.meal_area == ""
           fetch_recipe(@challenge.meal_category, @owner_event)
          end
        else
          @creator = Event.where(user_id: current_user.id, challenge_id: @challenge.id, role: "créateur", participation: "confirmed").first
          @creator.destroy

          @owner_event = Event.create(user_id: current_user.id, challenge_id: @challenge.id, role: "créateur", participation: "confirmed")
          # call to associate a recipe
          if @challenge.meal_category == nil || @challenge.meal_category == ""
            fetch_recipe_from_area(@challenge.meal_area, @owner_event)
          elsif @challenge.meal_area == nil || @challenge.meal_area == ""
           fetch_recipe(@challenge.meal_category, @owner_event)
          end
        end
    
        format.html { redirect_to edit_challenge_path(@challenge.id), notice: "Ok, le challenge vient d'être modifié." }
        format.json { render :show, status: :ok, location: @challenge }
      else
        flash.now[:warning] = "Echec :" + @challenge.errors.full_messages.join(" ")
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  def upd

    respond_to do |format|
      if @challenge.update(chal_params)
        flash[:success] = "Des modifications ont été apportées aux informations concernant l'utilisateur et ça c'est plutôt bien passé."
        format.html { redirect_to upd_challenge_path(@challenge), notice: "Dernière étape" }
        format.json { render :show, status: :ok, location: @challenge }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end  
  end

  # DELETE /challenges/1 or /challenges/1.json
  def destroy
    @challenge.destroy
    respond_to do |format|
      format.html { redirect_to user_path(current_user.id), notice: "Dommage, ton challenge n'est pas validé. tu pourras toujours un recréer un !!" }
      format.json { head :no_content }
    end
  end


  #get MealDB user search keyword
  def search_mealdb
    recepies = mealdb_url(params[:meal_category])
    unless recepies
      flash[:alert] = 'Pas de recettes trouvées'
      return render action: :index
      @recipe = recepies.first
    end
  end

  def search_mealdb_from_area
    recepies = mealdb_url(params[:meal_area])
    unless recepies
      flash[:alert] = 'Pas de recettes trouvées'
      return render action: :index
      @recipe = recepies.first
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_challenge
      @challenge = Challenge.find(params[:id])
    end

    def set_chal
      @challenge = Challenge.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def challenge_params
      params.require(:challenge).permit(:title, :status, :description, :numb_guest, :meal_category, :meal_area, :theme_choice)
    end

    def chal_params
      params.require(:challenge).permit(:id)
    end

end
