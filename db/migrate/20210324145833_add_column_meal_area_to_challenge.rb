class AddColumnMealAreaToChallenge < ActiveRecord::Migration[6.1]
  def change
    add_column :challenges, :meal_area, :string
  end
end
