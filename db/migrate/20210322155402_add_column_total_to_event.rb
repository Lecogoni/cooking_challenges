class AddColumnTotalToEvent < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :total_event, :integer, default: 0
  end
end
