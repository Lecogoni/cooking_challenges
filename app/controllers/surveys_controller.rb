class SurveysController < ApplicationController
  before_action :set_survey, only: %i[ show edit update destroy update_event_total ]

  # GET /surveys or /surveys.json
  def index
    @surveys = Survey.all
  end

  # GET /surveys/1 or /surveys/1.json
  def show
  end

  # GET /surveys/new
  def new
    @survey = Survey.new
  end

  # GET /surveys/1/edit
  def edit
  end

  # POST /surveys or /surveys.json
  def create
    @survey = Survey.new(survey_params)

    respond_to do |format|
      if @survey.save
        flash.now[:success] = "Création du questionaire."
        format.html { redirect_to @survey}
        format.json { render :show, status: :created, location: @survey }
      else
        flash.now[:danger] = "Echec :" + @survey.errors.full_messages.join(" ")
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /surveys/1 or /surveys/1.json
  def update
    respond_to do |format|
      if @survey.update(survey_params)
        # calcul et save le total de tous les questions> grades
        @sum = @survey.questions.all.sum(:grade)
        @survey.total_grade = @sum
        @survey.status = "done"
        @survey.save
        
        # update le total de l'event, la note global - somme des surveys 
        update_event_total()
        event_status(@survey.event)
        flash[:success] = "Le questionnaire vient d'être mis à jour."
        format.html { redirect_to events_path(id: @survey.event_id) } 
        format.json { render :show, status: :ok, location: @survey }
      else
        flash.now[:warning] = "Echec :" + @survey.errors.full_messages.join(" ")
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /surveys/1 or /surveys/1.json
  def destroy
    @survey.destroy
    respond_to do |format|
      format.html { redirect_to surveys_url, notice: "Le questionnaire vient d'être détruit." }
      format.json { head :no_content }
    end
  end

  def update_event_total
    @event = @survey.event
    @total = @event.surveys.all.sum(:total_grade)
    @event.total_event = @total
    @event.save
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey
      @survey = Survey.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def survey_params
      params.require(:survey).permit(:id, :comment, questions_attributes: [:id, :label, :grade])
    end
end
