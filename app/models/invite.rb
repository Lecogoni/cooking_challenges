class Invite < ApplicationRecord

  belongs_to :challenge
  
  validates :username, length: { in: 3..20 }, on: :update

end
