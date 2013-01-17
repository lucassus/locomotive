require 'spec_helper'

feature 'Admin panel' do

  describe 'an admin user' do
    let!(:user) { create(:user, :admin, email: 'admin@email.com') }

    background do
      login_with(user)
    end

    scenario 'should be able to access the admin panel' do
      visit root_path
      click_link 'Admin panel'

      current_path.should == admin_dashboard_path
      page.should have_content('Dashboard')
    end
  end

  describe 'a regular user' do
    let!(:user) { create(:user) }

    background do
      login_with(user)
      visit admin_dashboard_path
    end

    scenario 'should not be able to access the admin panel' do
      current_path.should == new_user_session_path
      page.should display_flash_message('You need to sign in or sign up before continuing.')
    end

    scenario 'should see the login form' do
      current_path.should == new_user_session_path
      page.should display_flash_message('You need to sign in or sign up before continuing.')

      fill_in 'Email', with: 'admin@email.com'
      fill_in 'Password', with: 'password'
    end
  end

end
