class User < ApplicationRecord
    has_many :categories
    has_many :items
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
  end