class AddColumnStatusToEvent < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :statut, :string, default: "pending"
  end
end
