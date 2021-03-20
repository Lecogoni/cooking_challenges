class Event < ApplicationRecord

  belongs_to :user
  belongs_to :challenge

  has_many : surveys
  
end
