class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|

      t.belongs_to :event

      t.string :idMeal
      t.string :Meal
      t.string :DrinkAlternate
      t.string :Category
      t.string :Area
      t.text :Instructions

      t.string :MealThumb
      t.string :Tags
      t.string :Youtube

      t.string :Ingredient1
      t.string :Ingredient2
      t.string :Ingredient3
      t.string :Ingredient4
      t.string :Ingredient5
      t.string :Ingredient6
      t.string :Ingredient7
      t.string :Ingredient8
      t.string :Ingredient9
      t.string :Ingredient10
      t.string :Ingredient11
      t.string :Ingredient12
      t.string :Ingredient13
      t.string :Ingredient14
      t.string :Ingredient15
      t.string :Ingredient16
      t.string :Ingredient17
      t.string :Ingredient18
      t.string :Ingredient19
      t.string :Ingredient20

      t.string :Measure1
      t.string :Measure2
      t.string :Measure3
      t.string :Measure4
      t.string :Measure5
      t.string :Measure6
      t.string :Measure7
      t.string :Measure8
      t.string :Measure9
      t.string :Measure10
      t.string :Measure11
      t.string :Measure12
      t.string :Measure13
      t.string :Measure14
      t.string :Measure15
      t.string :Measure16
      t.string :Measure17
      t.string :Measure18
      t.string :Measure19
      t.string :Measure20

      t.string :Source
      t.string :ImageSource
      t.string :CreativeCommonsConfirmed
      
      t.timestamps
    end
  end
end
