class RenameEventStatut < ActiveRecord::Migration[6.1]
  def change
    rename_column :events, :event_statut, :status
  end
end