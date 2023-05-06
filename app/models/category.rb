class Category < ApplicationRecord
    belongs_to :user
    has_many :items, dependent: :destroy

    validates :name, presence: true
    validates :icon, presence: true

    def total_transaction_amount
        items.sum(:amount)
    end
end
