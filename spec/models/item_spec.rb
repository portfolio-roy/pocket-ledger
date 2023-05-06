require 'rails_helper'

RSpec.describe Item, type: :model do
  context 'validation tests' do
    first_user = User.create(name: 'John', email: 'contact@example.com', password: 'Password')
    before(:each) do
      first_category = Category.create(name: 'Food', icon: 'icon.jpg', user_id: first_user.id)
      @item = Item.create(name: 'mango', amount: 100, user_id: first_user.id,
                          category_id: first_category.id)
    end

    it 'is invalid without a name' do
      @item.name = nil
      expect(@item).to_not be_valid
    end

    it 'is invalid without amount' do
      @item.amount = nil
      expect(@item).to_not be_valid
    end

    it 'amount must be a number' do
      @item.amount = 'house'
      expect(@item).to_not be_valid
    end

    it 'must have author ID' do
      @item.user_id = nil
      expect(@item).to_not be_valid
    end
  end
end
