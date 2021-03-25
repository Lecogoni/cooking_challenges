class RemoveGuestUsernameDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :age, nil
  end
end
