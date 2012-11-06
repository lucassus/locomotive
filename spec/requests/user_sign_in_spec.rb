require 'spec_helper'

feature 'Sign in' do
  let!(:user) { create(:user, email: 'user@email.com', :password => 'password') }
  let!(:suspended_user) { create(:user, :suspended, email: 'suspended@email.com', :password => 'password') }

  scenario 'with valid credentials' do
    sign_in_with('user@email.com', 'password')

    page.should display_flash_message('Signed in successfully.')
    user_should_be_signed_in_as('user@email.com')
  end

  scenario 'with invalid credentials' do
    sign_in_with('user@email.com', 'invalid password')

    user_should_not_be_signed_in
  end

  scenario 'with suspended account' do
    sign_in_with('suspended@email.com', 'password')

    user_should_not_be_signed_in
  end

  private

  def user_should_not_be_signed_in
    page.should display_flash_message('Invalid email or password.')
    page.should_not have_link('Sign out')
  end
end
