class RenameChallengerNumberOfGuest < ActiveRecord::Migration[6.1]
  def change
    rename_column :challenges, :invite_number, :number_of_guest
  end
end
