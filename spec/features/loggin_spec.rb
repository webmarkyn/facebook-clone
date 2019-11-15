# frozen_string_literal: true

require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'the signin process', type: :feature do
  before :each do
    User.create(email: 'something@cool.com', password: 'something123', password_confirmation: 'something123')
  end

  it 'signs me in' do
    visit '/'
    within '#new_user' do
      fill_in 'Email', with: 'something@cool.com'
      fill_in 'Password', with: 'something123'
    end
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully.')
  end
end
