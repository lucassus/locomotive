require 'spec_helper'

feature 'Sign up' do
  background do
    visit root_path
    click_link 'Sign up'
  end

  scenario 'an user can see the sign in form' do
    page.should have_content('Sign in')

    within 'form#new_user' do
      page.should have_field('Email')
      page.should have_field('Password')
      page.should have_field('Password confirmation')
      page.should have_button('Sign up')
    end
  end

  describe 'when user provides valid credentials' do
    background do
      fill_in 'Email', with: 'new@user.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
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
