class RenameEventColumnStatutToParticipation < ActiveRecord::Migration[6.1]
  def change
    rename_column :events, :statut, :participation
  end
end
