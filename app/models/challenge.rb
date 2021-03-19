class Challenge < ApplicationRecord

  has_many :events, dependent: :destroy
  has_many :users, through: :events

  has_many :guests, dependent: :destroy

  validates :numb_guest, {
    :presence => true,
    :allow_blank => false,
    :allow_nil => false,
  }

  validates :numb_guest, numericality: { only_integer: true }
  validates :numb_guest, :numericality => {:greater_than_or_equal_to => 1}
  
end
