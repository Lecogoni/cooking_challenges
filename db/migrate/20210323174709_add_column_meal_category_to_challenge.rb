class AddColumnMealCategoryToChallenge < ActiveRecord::Migration[6.1]
  def change
    add_column :challenges, :meal_category, :string
  end
end
