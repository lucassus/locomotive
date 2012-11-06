module Integration
  module SessionHelpers
    def sign_in_as(user, options = {})
      options.reverse_merge!(:password => 'password')

      visit root_path
      click_link 'Sign in'

      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => options[:password]
      click_button 'Sign in'
    end

    def logout
      visit root_path
      click_link('Sign out')
    end

    def user_should_be_signed_in_as(email)
      page.should display_flash_message('Welcome! You have signed up successfully.')
      page.should have_content(email)
    end

    def user_should_be_signed_out
      page.should have_content('Sign in')
    end
  end
end
