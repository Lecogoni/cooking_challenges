class Guest < ApplicationRecord

  belongs_to :challenge
  
  validates_presence_of :username, on: :update
  
end
