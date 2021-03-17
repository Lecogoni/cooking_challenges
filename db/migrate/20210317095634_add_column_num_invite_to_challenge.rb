class AddColumnNumInviteToChallenge < ActiveRecord::Migration[6.1]
  def change
    add_column :challenges, :invite_number, :integer
  end
end

