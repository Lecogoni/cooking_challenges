class Event < ApplicationRecord

  belongs_to :user
  belongs_to :challenge
  has_many :surveys, dependent: :destroy
  has_one :recipe, dependent: :destroy
  
end
