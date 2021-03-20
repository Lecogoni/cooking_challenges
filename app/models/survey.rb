class Survey < ApplicationRecord

  belongs_to :event
  belongs_to :surveyor, class_name: "User"
  
end
