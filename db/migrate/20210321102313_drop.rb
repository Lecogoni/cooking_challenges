class Drop < ActiveRecord::Migration[6.1]
  def change
    drop_table :table_surveys
  end
end
