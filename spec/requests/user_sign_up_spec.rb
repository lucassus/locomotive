require 'spec_helper'

feature 'User signs up' do
  scenario 'with valid email and password' do
    sign_up_with 'valid@example.com', 'password'
    user_should_be_signed_in_as('valid@example.com')
  end

  scenario 'with invalid email' do
    sign_up_with 'invalid_email', 'password'
    user_should_be_signed_out
  end

  scenario 'with blank password' do
    sign_up_with 'valid@example.com', ''
    user_should_be_signed_out
  end

  def sign_up_with(email, password)
    visit root_path
    click_link 'Sign up'

    fill_in 'Email', :with => email
    fill_in 'Password', :with => password
    fill_in 'Password confirmation', :with => password

    click_button 'Sign up'
  end
end
