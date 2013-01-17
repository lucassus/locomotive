module Macros
  module UserLogin
    def login_with(user, options = {})
      options.reverse_merge!(password: 'password')

      visit root_path
      click_link 'Sign in'

      within 'form' do
        find('#user_email').set user.email
        find('#user_password').set options[:password]

        click_button 'Sign in'
      end
    end

    def logout
      visit root_path
      click_link('Sign out')
    end
  end
end
