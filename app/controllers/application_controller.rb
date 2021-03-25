class ApplicationController < ActionController::Base

  before_action :configure_devise_parameters, if: :devise_controller?

  # Method qui permet a devise de prendre :username en compte lors du sign_up
  def configure_devise_parameters
    devise_parameter_sanitizer.permit(:sign_up) {|u| u.permit(:username, :email, :password, :password_confirmation)}
  end


  # fetch one recipe from an array result of search category 
  def fetch_recipe(meal_category, event)
    @recipies = search_mealdb_category(meal_category) # fetch array of recipes by search category
    @recipe = @recipies[rand(0...@recipies.length)] # Get one random recipe in the array
    @my_recipe = get_recipe_by(@recipe["idMeal"]) # fetch recipe details with the id
    save_recipe(@my_recipe, event) 
  end
  
  def fetch_recipe_from_area(meal_area, event)
    @recipies_area = search_mealdb_area(meal_area) # fetch array of recipes by search area
    @recipe = @recipies_area[rand(0...@recipies_area.length)] # Get one random recipe in the array
    @my_recipe = get_recipe_by(@recipe["idMeal"]) # fetch recipe details with the id
    save_recipe(@my_recipe, event) 
  end

  #set MealDB Url with keyword (Recipe)
  def mealdb_url_keyword(name)
    request_api(
      "https://themealdb.p.rapidapi.com/search.php?s=Arrabiata"
    )
  end

  #set MealDB Url with keyword (Area)
  def mealdb_area_url_keyword(name)
    request_api(
      "https://themealdb.p.rapidapi.com/filter.php?a=Canadian"
    )
  end
  
  # ==>set MealDB Url with category
  def mealdb_url_category(category)
    request_api(
      "https://themealdb.p.rapidapi.com/search.php?c=list"
    )
  end

  # ==>set MealDB Url with area
  def mealdb_url_area(area)
    request_api(
      "https://themealdb.p.rapidapi.com/list.php?a=list"
    )
  end

  #set MealDB Url with category
  def search_mealdb_category(category)
    request_api(
      "https://themealdb.p.rapidapi.com/filter.php?c=#{category}"
    )
  end

  #set MealDB Url with area
  def search_mealdb_area(area)
    request_api(
      "https://themealdb.p.rapidapi.com/filter.php?a=#{area}"
    )
  end

  
  # fetch the MealDb data
  def request_api(url)
    response = Excon.get(
      url,
      headers: {
        'X-RapidAPI-Host' => URI.parse(url).host,
        'X-RapidAPI-Key' => ENV['RAPIDAPI_API_KEY']
      }
    )

    @json_data = JSON.parse(response.body)
    @recipies = @json_data['meals']

    if response.status != 200
      return nil
    else
      return @recipies
    end
  end

  def get_recipe_by(id)
    request_api(
      "https://themealdb.p.rapidapi.com/lookup.php?i=#{id}"
    )
  end

  # fetch the MealDb data from area
  def request_api_from_area(url)
    response = Excon.get(
      url,
      headers: {
        'X-RapidAPI-Host' => URI.parse(url).host,
        'X-RapidAPI-Key' => ENV['RAPIDAPI_API_KEY']
      }
    )

    @json_data = JSON.parse(response.body)
    @recipies_area = @json_data['meals']

    if response.status != 200
      return nil
    else
      return @recipies_area
    end
  end

  def get_recipe_by(id)
    request_api(
      "https://themealdb.p.rapidapi.com/lookup.php?i=#{id}"
    )
  end


  # populate recipes db with new recipe associated to an event
  def save_recipe(my_recipe, event)

    @new_recipe = Recipe.create(
      event_id: event.id,
      idMeal: my_recipe[0]["idMeal"], 
      meal: my_recipe[0]["strMeal"],
      drinkAlternate: my_recipe[0]["strDrinkAlternate"],
      category: my_recipe[0]["strCategory"],
      area: my_recipe[0]["strArea"],
      instructions: my_recipe[0]["strInstructions"],
      mealThumb: my_recipe[0]["strMealThumb"],
      tags: my_recipe[0]["strTags"],
      youtube: my_recipe[0]["strYoutube"],
      ingredient1: my_recipe[0]["strIngredient1"],
      ingredient2: my_recipe[0]["strIngredient2"],
      ingredient3: my_recipe[0]["strIngredient3"],
      ingredient4: my_recipe[0]["strIngredient4"],
      ingredient5: my_recipe[0]["strIngredient5"],
      ingredient6: my_recipe[0]["strIngredient6"],
      ingredient7: my_recipe[0]["strIngredient7"],
      ingredient8: my_recipe[0]["strIngredient8"],
      ingredient9: my_recipe[0]["strIngredient9"],
      ingredient10: my_recipe[0]["strIngredient10"],
      ingredient11: my_recipe[0]["strIngredient11"],
      ingredient12: my_recipe[0]["strIngredient12"],
      ingredient13: my_recipe[0]["strIngredient13"],
      ingredient14: my_recipe[0]["strIngredient14"],
      ingredient15: my_recipe[0]["strIngredient15"],
      ingredient16: my_recipe[0]["strIngredient16"],
      ingredient17: my_recipe[0]["strIngredient17"],
      ingredient18: my_recipe[0]["strIngredient18"],
      ingredient19: my_recipe[0]["strIngredient19"],
      ingredient20: my_recipe[0]["strIngredient20"],
      measure1: my_recipe[0]["strMeasure1"],
      measure2: my_recipe[0]["strMeasure2"],
      measure3: my_recipe[0]["strMeasure3"],
      measure4: my_recipe[0]["strMeasure4"],
      measure5: my_recipe[0]["strMeasure5"],
      measure6: my_recipe[0]["strMeasure6"],
      measure7: my_recipe[0]["strMeasure7"],
      measure8: my_recipe[0]["strMeasure8"],
      measure9: my_recipe[0]["strMeasure9"],
      measure10: my_recipe[0]["strMeasure10"],
      measure11: my_recipe[0]["strMeasure11"],
      measure12: my_recipe[0]["strMeasure12"],
      measure13: my_recipe[0]["strMeasure13"],
      measure14: my_recipe[0]["strMeasure14"],
      measure15: my_recipe[0]["strMeasure15"],
      measure16: my_recipe[0]["strMeasure16"],
      measure17: my_recipe[0]["strMeasure17"],
      measure18: my_recipe[0]["strMeasure18"],
      measure19: my_recipe[0]["strMeasure19"],
      measure20: my_recipe[0]["strMeasure20"],
      source: my_recipe[0]["strSource"],
      imageSource: my_recipe[0]["strImageSource"],
      creativeCommonsConfirmed: my_recipe[0]["strCreativeCommonsConfirmed"]
    )
  end

  protected

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  def after_sign_up_path_for(resource)
    user_path(current_user)
  end

end
  