class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|

      t.string :label
      t.integer :grade, default: 0
      t.references :survey, foreign_key: true, index: true
      t.timestamps
    end
  end
end
