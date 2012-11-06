require 'spec_helper'

feature 'Sign out' do
  let!(:user) { create(:user, :email => 'user@email.com') }
  background { sign_in_as(user) }

  scenario 'successfully sign out' do
    sign_out

    page.should display_flash_message('Signed out successfully.')
    current_path.should == root_path

    user_should_be_signed_out
  end
end
