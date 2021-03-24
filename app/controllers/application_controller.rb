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
    @recipe_area = @recipies_area[rand(0...@recipies_area.length)] # Get one random recipe in the array
    @my_recipe_area = get_recipe_by(@recipe_area["idMeal"]) # fetch recipe details with the id
    save_recipe(@my_recipe_area, event) 
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


  # populate recipes db with new recipe associated to an event
  def save_recipe(my_recipe, event)

    @new_recipe = Recipe.create(
      event_id: event.id,
      idMeal: my_recipe[0]["idMeal"], 
      Meal: my_recipe[0]["strMeal"],
      DrinkAlternate: my_recipe[0]["strDrinkAlternate"],
      Category: my_recipe[0]["strCategory"],
      Area: my_recipe[0]["strArea"],
      Instructions: my_recipe[0]["strInstructions"],
      MealThumb: my_recipe[0]["strMealThumb"],
      Tags: my_recipe[0]["strTags"],
      Youtube: my_recipe[0]["strYoutube"],
      Ingredient1: my_recipe[0]["strIngredient1"],
      Ingredient2: my_recipe[0]["strIngredient2"],
      Ingredient3: my_recipe[0]["strIngredient3"],
      Ingredient4: my_recipe[0]["strIngredient4"],
      Ingredient5: my_recipe[0]["strIngredient5"],
      Ingredient6: my_recipe[0]["strIngredient6"],
      Ingredient7: my_recipe[0]["strIngredient7"],
      Ingredient8: my_recipe[0]["strIngredient8"],
      Ingredient9: my_recipe[0]["strIngredient9"],
      Ingredient10: my_recipe[0]["strIngredient10"],
      Ingredient11: my_recipe[0]["strIngredient11"],
      Ingredient12: my_recipe[0]["strIngredient12"],
      Ingredient13: my_recipe[0]["strIngredient13"],
      Ingredient14: my_recipe[0]["strIngredient14"],
      Ingredient15: my_recipe[0]["strIngredient15"],
      Ingredient16: my_recipe[0]["strIngredient16"],
      Ingredient17: my_recipe[0]["strIngredient17"],
      Ingredient18: my_recipe[0]["strIngredient18"],
      Ingredient19: my_recipe[0]["strIngredient19"],
      Ingredient20: my_recipe[0]["strIngredient20"],
      Measure1: my_recipe[0]["strMeasure1"],
      Measure2: my_recipe[0]["strMeasure2"],
      Measure3: my_recipe[0]["strMeasure3"],
      Measure4: my_recipe[0]["strMeasure4"],
      Measure5: my_recipe[0]["strMeasure5"],
      Measure6: my_recipe[0]["strMeasure6"],
      Measure7: my_recipe[0]["strMeasure7"],
      Measure8: my_recipe[0]["strMeasure8"],
      Measure9: my_recipe[0]["strMeasure9"],
      Measure10: my_recipe[0]["strMeasure10"],
      Measure11: my_recipe[0]["strMeasure11"],
      Measure12: my_recipe[0]["strMeasure12"],
      Measure13: my_recipe[0]["strMeasure13"],
      Measure14: my_recipe[0]["strMeasure14"],
      Measure15: my_recipe[0]["strMeasure15"],
      Measure16: my_recipe[0]["strMeasure16"],
      Measure17: my_recipe[0]["strMeasure17"],
      Measure18: my_recipe[0]["strMeasure18"],
      Measure19: my_recipe[0]["strMeasure19"],
      Measure20: my_recipe[0]["strMeasure20"],
      Source: my_recipe[0]["strSource"],
      ImageSource: my_recipe[0]["strImageSource"],
      CreativeCommonsConfirmed: my_recipe[0]["strCreativeCommonsConfirmed"]
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
  