class AddColumnToChallenge < ActiveRecord::Migration[6.1]
  def change
    add_column :challenges, :theme_choice, :string
  end
end
