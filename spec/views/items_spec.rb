require 'rails_helper'

RSpec.describe 'Items', type: :feature do
  before(:all) do
    User.create(name: 'John', email: 'contact@example.com', password: 'Password')
    visit new_user_session_path
    fill_in('Email*', with: 'contact@example.com')
    fill_in('Password*', with: 'Password')
    click_button 'Log In'
  end
end