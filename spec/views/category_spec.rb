require 'rails_helper'

RSpec.describe 'Category', type: :feature do
  before(:each) do
    User.create(name: 'John', email: 'contact@example.com', password: 'Password')
    visit new_user_session_path
    fill_in('Email*', with: 'contact@example.com')
    fill_in('Password*', with: 'Password')
    click_button 'Log In'
  end

  scenario 'show categories page' do
    sleep(1)
    visit categories_path
    assert page.has_content?('CATEGORIES')
  end

  scenario 'create new category' do
    sleep(1)
    visit new_category_path
    fill_in('Enter Category name', with: 'Food')
    fill_in('Enter Category icon link', with: 'demo_icon')

    click_button 'Create'
    assert page.has_content?('NEW TRANSACTION')
  end
end
