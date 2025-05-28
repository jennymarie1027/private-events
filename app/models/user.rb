class User < ApplicationRecord
  has_many :events, dependent: :destroy
  has_many :rsvps, foreign_key: 'guest_id', dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

