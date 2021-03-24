class RemoveDefaultGuestUsername < ActiveRecord::Migration[6.1]
  def change
    change_column_default :guests, :username, nil
  end
end
