class CreateGuests < ActiveRecord::Migration[6.1]
  def change
    create_table :guests do |t|

      t.string :username, default: ""
      t.string :email
      t.references :challenge, foreign_key: true, index: true

      t.timestamps
    end
  end
end
