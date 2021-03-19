class ChangeChallengeNumberGuestName < ActiveRecord::Migration[6.1]
  def change
    rename_column :challenges, :number_of_guest, :numb_guest
  end
end
