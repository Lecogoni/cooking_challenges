class TravelsController < ApplicationController
  before_action :set_travel, only: %i[ show edit update destroy ]

  # GET /travels or /travels.json
  def index
  end

  # GET /travels/1 or /travels/1.json
  def show
  end

  def search
    countries = find_country(params[:country])
    unless countries
      flash[:alert] = 'Country not found'
      return render action: :index
      @country = countries.first
      @weather = find_weather(@country['capital'], @country['alpha2Code'])
    end
  end

  def find_weather(city, country_code)
    query = URI.encode("#{city},#{country_code}")
    request_api(
      "https://community-open-weather-map.p.rapidapi.com/forecast?q=#{query}"
    )
  end

  # GET /travels/new
  def new
    @travel = Travel.new
  end

  # GET /travels/1/edit
  def edit
  end

  # POST /travels or /travels.json
  def create
    @travel = Travel.new(travel_params)

    respond_to do |format|
      if @travel.save
        format.html { redirect_to @travel, notice: "Travel was successfully created." }
        format.json { render :show, status: :created, location: @travel }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @travel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /travels/1 or /travels/1.json
  def update
    respond_to do |format|
      if @travel.update(travel_params)
        format.html { redirect_to @travel, notice: "Travel was successfully updated." }
        format.json { render :show, status: :ok, location: @travel }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @travel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /travels/1 or /travels/1.json
  def destroy
    @travel.destroy
    respond_to do |format|
      format.html { redirect_to travels_url, notice: "Travel was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_travel
      @travel = Travel.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def travel_params
      params.fetch(:travel, {})
    end

    def request_api(url)
      response = Excon.get(
        url,
        headers: {
          'X-RapidAPI-Host' => URI.parse(url).host,
          'X-RapidAPI-Key' => ENV.fetch('RAPIDAPI_API_KEY')
        }
      )

      @json_data = JSON.parse(response.body)

      puts "------------------------------------"
      puts response
      puts "------------------------------------"
      puts response.status
      puts "------------------------------------"
      puts response.body.class
      puts "------------------------------------"
      puts response.body
      puts "------------------------------------"
      puts @json_data
      puts "------------------------------------"
      puts @json_data.class
      puts "------------------------------------"
      puts @json_data[0].class
          @at = @json_data[0]
      puts "------------------------------------"
      puts @at['currencies']
      puts "------------------------------------"
      puts 
      puts "------------------------------------"
      return nil if response.status != 200
    end
    def find_country(name)
      request_api(
        "https://restcountries-v1.p.rapidapi.com/name/#{URI.encode(name)}"
      )
    end
end


