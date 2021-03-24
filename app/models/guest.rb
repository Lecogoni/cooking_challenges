class Guest < ApplicationRecord

  belongs_to :challenge
  

  validates_length_of :username, :minimum => 3, on: :update
  
end
