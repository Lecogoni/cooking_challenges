class MealsController < ApplicationController
  require 'dotenv'
  Dotenv.load('.env')
  before_action :set_meal, only: %i[ show edit update destroy ]

  # GET /meals or /meals.json
  def index
  end

  def search
    categories = find_list(params[:list])
  
    unless categories
      flash[:alert] = 'list not found'
      return render action: :index
    end

    @category = categories.first
    @meal = find_meal(@meal['capital'], @meal['alpha2Code'])
  end

  def find_meal(strMeal)
    query = URI.encode("#{strMeal}")
    request_api(
      "https://themealdb.p.rapidapi.com/filter.php?c=Seafood#{query}"
    )
  end

  # GET /meals/1 or /meals/1.json
  def show
  end

  # GET /meals/new
  def new
    @meal = Meal.new
  end

  # GET /meals/1/edit
  def edit
  end

  # POST /meals or /meals.json
  def create
    @meal = Meal.new(meal_params)

    respond_to do |format|
      if @meal.save
        format.html { redirect_to @meal, notice: "Meal was successfully created." }
        format.json { render :show, status: :created, location: @meal }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meals/1 or /meals/1.json
  def update
    respond_to do |format|
      if @meal.update(meal_params)
        format.html { redirect_to @meal, notice: "Meal was successfully updated." }
        format.json { render :show, status: :ok, location: @meal }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meals/1 or /meals/1.json
  def destroy
    @meal.destroy
    respond_to do |format|
      format.html { redirect_to meals_url, notice: "Meal was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal
      @meal = Meal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def meal_params
      params.fetch(:meal, {})
    end

    def request_api(url)
      require 'dotenv'
      Dotenv.load('.env')
      response = Excon.get(
        url,
        headers: {
          'X-RapidAPI-Host' => URI.parse(url).host,
          'X-RapidAPI-Key' => ENV.fetch('RAPIDAPI_API_KEY')
        }
      )
      return nil if response.status != 200
      JSON.parse(response.body)
    end
    def find_list(name)
      request_api(
        "https://themealdb.p.rapidapi.com/list.php?c=#{URI.encode(name)}"
      )
    end
end
