require 'spec_helper'

feature 'Sign out' do
  background do
    user = create(:user, email: 'user@email.com')
    login_with(user)

    visit root_path
    click_link 'Sign out'
  end

  scenario 'successfully sign out' do
    page.should display_flash_message('Signed out successfully.')
    current_path.should == root_path
  end
end
