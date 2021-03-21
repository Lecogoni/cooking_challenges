class Survey < ApplicationRecord

  belongs_to :event
  belongs_to :surveyor, class_name: "User"

  has_many :questions, dependent: :destroy
  accepts_nested_attributes_for :questions

  
  
end
