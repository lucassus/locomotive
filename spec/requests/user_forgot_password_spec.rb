require 'spec_helper'

describe 'User forgot password feature' do
  let!(:user) { create(:user, :email => 'user@email.com') }

  before do
    visit root_path
    click_link 'Sign in'
    click_link 'Forgot your password?'
  end

  it 'should show forgot password form' do
    page.should have_content('Forgot your password?')

    within 'form#new_user.new_user' do
      page.should have_field('Email')
      page.should have_button('Send me reset password instructions')
    end
  end

  describe 'when user fill in form with valid email' do
    before do
      fill_in 'Email', :with => 'user@email.com'
      click_button 'Send me reset password instructions'
    end

    it 'should display flash message' do
      page.should have_content('You will receive an email with instructions about how to reset your password in a few minutes.')
    end
  end

end
