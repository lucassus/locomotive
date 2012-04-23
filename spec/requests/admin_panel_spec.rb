require 'spec_helper'

feature 'Admin panel' do

  describe 'an admin user' do
    let!(:user) { create(:user, :email => 'admin@email.com', :admin => true) }

    scenario 'should be able to access the admin panel' do
      visit admin_dashboard_path

      current_path.should == new_user_session_path
      page.should have_content('You need to sign in or sign up before continuing.')

      fill_in 'Email', :with => 'admin@email.com'
      fill_in 'Password', :with => 'password'
      click_button 'Sign in'

      current_path.should == admin_dashboard_path
      page.should have_content('Signed in successfully.')
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
      page.should have_content('You need to sign in or sign up before continuing.')
    end
  end

end
