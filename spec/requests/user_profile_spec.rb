require 'spec_helper'

describe 'User profile feature' do
  let!(:user) { create(:user, :email => 'user@email.com') }

  before do
    login_with(user)
    visit root_path
    click_link 'Profile'
  end

  it 'should display user profile form' do
    page.should have_content('Edit User')

    within 'form#edit_user.edit_user' do
      page.should have_field('Email')
      page.should have_field('Password')
      page.should have_field('Password confirmation')
      page.should have_field('Current password')
    end
  end

  describe 'change password' do
    before do
      fill_in 'Password', :with => 'new password'
      fill_in 'Password confirmation', :with => 'new password'
      fill_in 'Current password', :with => 'password'
      click_button 'Update'
    end

    it 'should display flash message' do
      page.should have_content('You updated your account successfully.')
    end

    it 'should allow user to login with new password' do
      logout
      login_with(user, 'new password')
      page.should have_content('Signed in successfully.')
    end
  end

end
