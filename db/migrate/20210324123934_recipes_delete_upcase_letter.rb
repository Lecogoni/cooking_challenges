class RecipesDeleteUpcaseLetter < ActiveRecord::Migration[6.1]
  def change
    rename_column :recipes, :Meal, :meal
    rename_column :recipes, :DrinkAlternate, :drinkAlternate
    rename_column :recipes, :Category, :category
    rename_column :recipes, :Area, :area
    rename_column :recipes, :Instructions, :instructions
    rename_column :recipes, :MealThumb, :mealThumb
    rename_column :recipes, :Tags, :tags
    rename_column :recipes, :Youtube, :youtube
    rename_column :recipes, :Ingredient1, :ingredient1 
    rename_column :recipes, :Ingredient2, :ingredient2
    rename_column :recipes, :Ingredient3, :ingredient3
    rename_column :recipes, :Ingredient4, :ingredient4
    rename_column :recipes, :Ingredient5, :ingredient5
    rename_column :recipes, :Ingredient6, :ingredient6
    rename_column :recipes, :Ingredient7, :ingredient7
    rename_column :recipes, :Ingredient8, :ingredient8
    rename_column :recipes, :Ingredient9, :ingredient9
    rename_column :recipes, :Ingredient10, :ingredient10
    rename_column :recipes, :Ingredient11, :ingredient11
    rename_column :recipes, :Ingredient12, :ingredient12
    rename_column :recipes, :Ingredient13, :ingredient13
    rename_column :recipes, :Ingredient14, :ingredient14
    rename_column :recipes, :Ingredient15, :ingredient15
    rename_column :recipes, :Ingredient16, :ingredient16
    rename_column :recipes, :Ingredient17, :ingredient17
    rename_column :recipes, :Ingredient18, :ingredient18
    rename_column :recipes, :Ingredient19, :ingredient19
    rename_column :recipes, :Ingredient20, :ingredient20
    rename_column :recipes, :Measure1, :measure1
    rename_column :recipes, :Measure2, :measure2
    rename_column :recipes, :Measure3, :measure3
    rename_column :recipes, :Measure4, :measure4
    rename_column :recipes, :Measure5, :measure5
    rename_column :recipes, :Measure6, :measure6
    rename_column :recipes, :Measure7, :measure7
    rename_column :recipes, :Measure8, :measure8
    rename_column :recipes, :Measure9, :measure9
    rename_column :recipes, :Measure10, :measure10
    rename_column :recipes, :Measure11, :measure11
    rename_column :recipes, :Measure12, :measure12
    rename_column :recipes, :Measure13, :measure13
    rename_column :recipes, :Measure14, :measure14
    rename_column :recipes, :Measure15, :measure15
    rename_column :recipes, :Measure16, :measure16
    rename_column :recipes, :Measure17, :measure17
    rename_column :recipes, :Measure18, :measure18
    rename_column :recipes, :Measure19, :measure19
    rename_column :recipes, :Measure20, :measure20
    rename_column :recipes, :Source, :source
    rename_column :recipes, :ImageSource, :imageSource
    rename_column :recipes, :CreativeCommonsConfirmed, :creativeCommonsConfirmed

  end
end























    
    
    
    
    
    
    