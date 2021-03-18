class AddDefaultToInvitesUsername < ActiveRecord::Migration[6.1]
  def change
    change_column :invites, :username, :string, default: ""
  end
end
