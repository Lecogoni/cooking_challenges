class CreateChallenges < ActiveRecord::Migration[6.1]
  def change
    create_table :challenges do |t|

      t.string :title, default: ""
      t.string :statut, default: "pending"
      t.string :description, default: ""

      t.timestamps
    end
  end
end
