require 'spec_helper'

feature 'Sign in via Facebook' do
  let!(:user) { create(:user, :with_facebook_account) }

  background do
    visit root_path
    click_link 'Sign in'

    OmniAuth.config.mock_auth[:facebook] = {
        :provider => 'facebook',
        :uid => user.facebook_account.uid,
        :credentials => {
            :token => 'facebook token'
        }
    }
  end

  scenario 'click login via facebook' do
    click_link 'Login via Facebook'

    page.should display_flash_message('Signed in successfully.')
  end

end
