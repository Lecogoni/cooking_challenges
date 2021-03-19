class ChangeChallengeColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :challenges, :statut, :status
  end
end
