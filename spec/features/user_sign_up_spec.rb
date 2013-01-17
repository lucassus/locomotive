require 'spec_helper'

feature 'Sign up' do
  background do
    visit root_path
    click_link 'Sign up'
  end

  describe 'when user provides valid credentials' do
    background do
      fill_in 'Email', with: 'new@user.com'
      find('#user_password').set 'password'
      find('#user_password_confirmation').set 'password'

      click_button 'Sign up'
    end

    scenario 'he should be logged in' do
      page.should display_flash_message('Welcome! You have signed up successfully.')
      page.should have_content('new@user.com')
      current_path.should == root_path

      User.find_by_email('new@user.com').should_not be_nil
    end
  end
end
