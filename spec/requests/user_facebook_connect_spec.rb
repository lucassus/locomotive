require 'spec_helper'

feature 'Facebook connect' do
  let(:uid) { '123545' }
  let!(:user) { create(:user, :email => 'user@email.com') }

  background do
    login_with(user)
    visit root_path

    OmniAuth.config.mock_auth[:facebook] = {
        :provider => 'facebook',
        :uid => uid,
        :credentials => {
            :token => 'facebook token'
        }
    }
  end

  context 'when an user is not connected with Facebook account' do
    scenario 'connect with Facebook account' do
      click_link 'Accounts'
      page.should have_content('My connected accounts')
      click_link 'Connect with Facebook'

      page.should display_flash_message('Authentication successful.')

      account = user.accounts.last
      account.should_not be_nil
      account.provider.should == UserAccount::FACEBOOK

      click_link 'Sign out'
      click_link 'Sign in'
      click_link 'Login via Facebook'

      page.should display_flash_message('Signed in successfully.')
      page.should have_content(user.email)
    end
  end

  context 'when an user is connected with Facebook account' do
    let!(:user_facebook_account) { create(:facebook_account, :user => user, :uid => uid) }

    scenario 'disconnect' do
      click_link 'Accounts'
      page.should have_content('My connected accounts')
      click_link 'Delete'
      page.should display_flash_message('Account was successfully deleted.')

      user.accounts.should be_empty
    end
  end

end
