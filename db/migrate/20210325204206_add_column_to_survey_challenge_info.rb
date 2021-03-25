class AddColumnToSurveyChallengeInfo < ActiveRecord::Migration[6.1]
  def change
    add_column :surveys, :challenge_id, :string
  end
end
