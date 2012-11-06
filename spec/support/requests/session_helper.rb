module Integration
  module SessionHelpers
    def sign_in_as(user, options = {})
      options.reverse_merge!(:password => 'password')
      sign_in_with(user.email, options[:password])
    end

    def sign_in_with(email, password = 'password')
      visit root_path
      click_link 'Sign in'

      fill_in 'Email', :with => email
      fill_in 'Password', :with => password

      click_button 'Sign in'
    end

    def sign_out
      visit root_path
      click_link('Sign out')
    end

    def user_should_be_signed_in_as(email)
      page.should have_content(email)
      page.should have_link('Sign out')
    end

    def user_should_be_signed_out
      page.should have_content('Sign in')
    end
  end
end
