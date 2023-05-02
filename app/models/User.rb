class User < ApplicationRecord
  validates :full_name, presence: true
  validates :email, presence: true, uniqueness: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
