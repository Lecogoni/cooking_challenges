class AddColumnUsernameToInvite < ActiveRecord::Migration[6.1]
  def change
    add_column :invites, :username, :string
  end
end
