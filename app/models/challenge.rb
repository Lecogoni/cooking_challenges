class Challenge < ApplicationRecord

  has_many :events, dependent: :destroy
  has_many :users, through: :events
  
end
