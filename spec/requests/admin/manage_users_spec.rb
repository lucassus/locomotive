require 'spec_helper'

feature 'Admin can manage users' do
  let!(:admin_user) { create(:user, :admin) }

  background do
    3.times { create(:user) }
    sign_in_as(admin_user)

    visit admin_dashboard_path
    click_link 'Users'
  end

  scenario 'an admin can see the list of users' do
    current_path.should == admin_users_path

    within_table 'users' do
      page.should have_content('Id')
      page.should have_content('Email')
      page.should have_content('Admin')
      page.should have_content('Created At')
      page.should have_content('Last Sign In At')

      page.should have_selector('tbody tr', :count => 4)
    end

    within 'ul.scopes' do
      click_link 'Admin'
    end

    within_table 'users' do
      page.should have_css('tbody tr', :count => 1)
    end
  end

  scenario 'an admin can edit an user' do
    user = User.last

    within "tr#user_#{user.id}" do
      click_link 'Edit'
    end

    current_path.should == edit_admin_user_path(user, :locale => nil)
    within 'form#edit_user' do
      page.should have_field('Email', :with => user.email)
      page.should have_field('Password')
      page.should have_field('Password confirmation')
      page.should have_button('Update User')

      fill_in 'Email', :with => 'new@email.com'
      fill_in 'Password', :with => 'password'
      fill_in 'Password confirmation', :with => 'password'
      click_button 'Update User'
    end

    within '.flashes' do
      page.should have_content('User was successfully updated.')
    end

    current_path.should == admin_user_path(user, :locale => nil)
    page.should have_content('new@email.com')
  end

  scenario 'an admin can suspend an user' do
    user = User.last

    within "tr#user_#{user.id}" do
      click_link 'Edit'
    end

    within 'form#edit_user' do
      check 'Suspended'
      click_button 'Update User'
    end

    within '.flashes' do
      page.should have_content('User was successfully updated.')
    end

    current_path.should == admin_user_path(user, :locale => nil)

    user.reload
    user.should be_suspended
  end
end
