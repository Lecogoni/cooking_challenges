class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events, dependent: :destroy
  has_many :challenges, through: :events
  has_many :surveys, foreign_key: 'surveyor_id', class_name: "Survey"

  validates :username, presence: true

  #after_create :welcome_send

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

end
