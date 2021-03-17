class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|

      t.string :event_statut, default: "unscheduled"
      t.string :role, default: "participant"
      t.references :user, foreign_key: true, index: true
      t.references :challenge, foreign_key: true, index: true

      t.timestamps
    end
  end
end
