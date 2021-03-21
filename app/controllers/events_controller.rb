class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy toggle_participation toggle_status ]

  # GET /events or /events.json
  def index
    @events = Event.all
  end

  # GET /events/1 or /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  def toggle_participation
    if @event.participation == "confirmed"
      @event.participation = "pending"
      @event.save
    else
      @event.participation = "confirmed"
      @event.save
    end
  end
  
  # change event status and create the needed number of survey matching the event
  def toggle_status

    @questions_list = [
      "est ce que le plat est conforme au thème, à la recette ?", 
      "est-ce que c'était bon ?", 
      "est ce que l'hôte a apporté une touche personnel à la recette ?",
      "quel note donneriez vous à la présentation ?"
    ]

    
    if @event.status == "unscheduled"
      @event.status = "done"
      @event.save

      # défini le nombre de Survey à créer en comptant le nombre de participant mois le participant de l'event actuel
      @event_survey = Event.where(challenge_id: @event.challenge_id).where.not(user_id: @event.user_id).to_a

      @event_survey.each_with_index do |survey, index|
        @new_survey = Survey.create(event_id: @event.id, surveyor_id: survey.user_id )
          @questions_list.each do |question|
            @new_question = Question.create(survey_id: @new_survey.id, label: question)
          end
      end

    else
      @event.status = "unscheduled"
      @event.save
    end
  end


  def survey_question()

    @questions_list = [
      "est ce que le plat est conforme au thème, à la recette ?", 
      "est-ce que c'était bon ?", 
      "est ce que l'hôte a apporté une touche personnel à la recette ?",
      "quel note donneriez vous à la présentation ?"
    ]

    return @questions_list
    
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.fetch(:event, {})
    end
end
