require 'spec_helper'

feature 'User profile' do
  let!(:user) { create(:user, :email => 'user@email.com') }

  background do
    login_with(user)
    visit root_path
    click_link 'Profile'
  end

  scenario 'an user can see his profile' do
    page.should have_content('Edit User')

    within 'form#edit_user' do
      page.should have_field('Email')
      page.should have_field('Password')
      page.should have_field('Password confirmation')
      page.should have_field('Current password')
    end
  end

  describe 'change password' do
    background do
      fill_in 'Password', :with => 'new password'
      fill_in 'Password confirmation', :with => 'new password'
      fill_in 'Current password', :with => 'password'
      click_button 'Update'
    end

    scenario 'an user can see flash message' do
      page.should have_content('You updated your account successfully.')
    end

    scenario 'an user should be able to login with new password' do
      logout
      login_with(user, :password => 'new password')
      page.should have_content('Signed in successfully.')
    end
  end
end
