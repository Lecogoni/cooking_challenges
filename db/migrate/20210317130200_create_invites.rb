class CreateInvites < ActiveRecord::Migration[6.1]
  def change
    create_table :invites do |t|

      t.string :email
      t.references :challenge, foreign_key: true, index: true

      t.timestamps
      
    end
  end
end
