class AddColumnTotalToSurvey < ActiveRecord::Migration[6.1]
  def change
    add_column :surveys, :total_grade, :integer, default: 0
  end
end
