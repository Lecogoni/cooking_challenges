class CreateSurveys < ActiveRecord::Migration[6.1]
  def change
    create_table :surveys do |t|

      t.references :event, foreign_key: true, index: true
      t.references :surveyor, index: true

      t.timestamps
    end
  end
end
