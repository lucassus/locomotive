require 'spec_helper'

feature 'Sign in' do
  let!(:user) { create(:user, :password => 'password') }
  background do
    visit root_path
    click_link 'Sign in'
  end

  scenario 'an user can see the sign in form' do
    page.should have_content('Sign in')

    within 'form#new_user' do
      page.should have_field('Email')
      page.should have_field('Password')
      page.should have_unchecked_field('Remember me')
      page.should have_button('Sign in')
    end
  end

  describe 'when an user provides valid credentials' do
    background do
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => 'password'
      click_button 'Sign in'
    end

    scenario 'he should be logged in' do
      current_path.should == root_path
      page.should display_flash_message('Signed in successfully.')
      page.should have_content(user.email)
      page.should have_link('Sign out')
    end
  end

  describe 'when an user is suspended' do
    before { user.update_attributes(suspended: true) }

    background do
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => 'password'
      click_button 'Sign in'
    end

    scenario 'he should not be logged in' do
      current_path.should == new_user_session_path
      page.should display_flash_message('Invalid email or password.')
    end
  end
end
