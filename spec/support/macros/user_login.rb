module Macros
  module UserLogin
    def login_with(user, options = {})
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
  end
end
