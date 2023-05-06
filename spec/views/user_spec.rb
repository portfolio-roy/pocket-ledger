require 'rails_helper'

RSpec.describe 'Users', type: :feature do
  scenario 'show home page' do
    visit root_path
    assert page.has_content?('Log In')
  end

  scenario 'user can sign up' do
    visit new_user_registration_path
    fill_in('Enter your name here', with: 'John')
    fill_in('Enter your email', with: 'contact@john.me')
    fill_in('Enter new password', with: 'Password')
    fill_in('Confirm password', with: 'Password')
    click_button 'Sign Up'
    expect(page).to have_content 'CATEGORIES'
  end

  scenario 'show sign-in page' do
    User.create(name: 'John', email: 'contact@john.me', password: 'Password')
    visit new_user_session_path
    fill_in('Email*', with: 'contact@john.me')
    fill_in('Password*', with: 'Password')
    click_button 'Log In'
    expect(page).to have_content 'CATEGORIES'
  end
end
