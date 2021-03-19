class Challenge < ApplicationRecord

  has_many :events, dependent: :destroy
  has_many :users, through: :events

  has_many :guests, dependent: :destroy
  has_many :invites, dependent: :destroy

  validates :invite_number, {
    :presence => true,
    :allow_blank => false,
    :allow_nil => false,
  }

  validates :invite_number, numericality: { only_integer: true }
  validates :invite_number, :numericality => {:greater_than_or_equal_to => 1}
  
end
