require 'spec_helper'

feature 'Sign up via Facebook' do

  background do
    visit root_path
    click_link 'Sign in'

    OmniAuth.config.mock_auth[:facebook] = {
      :provider => 'facebook',
      :uid => '123545',
      :credentials => {
        :token => 'facebook token'
      }
    }
  end

  scenario 'click login via facebook' do
    click_link 'Login via Facebook'
    page.should have_content('Sign up')

    within 'form#new_user' do
      fill_in 'Email', :with => 'facebook@user.com'
      fill_in 'Password', :with => 'password'
      fill_in 'Password confirmation', :with => 'password'
      click_button 'Sign up'
    end

    page.should have_content('Welcome! You have signed up successfully.')
    page.should have_content('facebook@user.com')
    current_path.should == root_path

    user = User.find_by_email('facebook@user.com')
    user.should_not be_nil
    user.accounts.should have(1).item

    facebook_account = user.accounts.last
    facebook_account.provider.should == 'facebook'
    facebook_account.uid.should == '123545'
    facebook_account.token.should == 'facebook token'

    click_link 'Sign out'

    visit root_path
    click_link 'Sign in'
    click_link 'Login via Facebook'

    page.should have_content('Signed in successfully.')
    page.should have_content('facebook@user.com')
  end

end
