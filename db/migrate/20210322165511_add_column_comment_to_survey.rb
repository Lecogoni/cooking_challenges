class AddColumnCommentToSurvey < ActiveRecord::Migration[6.1]
  def change
    add_column :surveys, :comment, :string
  end
end
