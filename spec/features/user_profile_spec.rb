require 'spec_helper'

feature 'User profile' do
  let!(:user) { create(:user, email: 'user@email.com') }

  background do
    login_with(user)
    visit root_path
    click_link 'My profile'
  end

  describe 'change password' do
    background do
      within 'form' do
        find('#user_password').set 'new password'
        find('#user_password_confirmation').set 'new password'
        find('#user_current_password').set 'password'

        click_button 'Update'
      end
    end

    scenario 'an user can see flash message' do
      page.should display_flash_message('You updated your account successfully.')
    end

    scenario 'an user should be able to login with new password' do
      logout
      login_with(user, password: 'new password')
      page.should display_flash_message('Signed in successfully.')
    end
  end
end
