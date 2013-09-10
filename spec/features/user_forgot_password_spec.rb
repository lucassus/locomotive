require 'spec_helper'

feature 'Reset password' do
  let!(:user) { create(:user, email: 'user@email.com') }

  background do
    visit root_path
    click_link 'Sign in'
    click_link 'Forgot your password?'
  end

  scenario 'an user can see new password request form' do
    page.should have_content('Forgot your password?')

    within 'form#new_user' do
      page.should have_field('Email')
      page.should have_button('Send me reset password instructions')
    end
  end

  describe 'when user request a new password' do
    background do
      fill_in 'Email', with: 'user@email.com'
      click_button 'Send me reset password instructions'
      open_email 'user@email.com'
    end

    describe 'reset password email' do
      subject { current_email }

      its(:from) { should include('locomotive@example.com') }
      its(:to) { should include('user@email.com') }
      its(:subject) { should == 'Reset password instructions' }

      it { should have_link('Change my password') }
    end

    scenario 'user should see the flash message' do
      page.should display_flash_message('You will receive an email with instructions about how to reset your password in a few minutes.')
    end

    describe 'when the user follows link in the email' do
      background do
        current_email.click_link 'Change my password'
      end

      scenario 'an user can see reset password form' do
        page.should have_content('Change your password')

        page.should have_field('New password')
        page.should have_field('Confirm your new password')
      end

      context 'when user provide a new password' do
        background do
          within 'form#new_user' do
            fill_in 'New password', with: '123123123'
            fill_in 'Confirm your new password', with: '123123123'
            click_button 'Change my password'
          end
        end

        scenario 'user should see the flash message' do
          page.should display_flash_message('Your password was changed successfully. You are now signed in.')
        end

        scenario 'user should be able to login with his new password' do
          click_link 'Sign out'
          click_link 'Sign in'
          fill_in 'Email', with: 'user@email.com'
          fill_in 'Password', with: '123123123'
          click_button 'Sign in'

          page.should display_flash_message('Signed in successfully.')
        end
      end
    end
  end
end
