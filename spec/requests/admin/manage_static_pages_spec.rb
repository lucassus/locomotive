require 'spec_helper'

feature 'Admin can manage static pages' do
  let!(:admin_user) { create(:admin_user) }

  background do
    create(:static_page, :name => :about)
    create(:static_page, :name => :contact)
    login_with(admin_user)

    visit admin_dashboard_path
    click_link 'Static Pages'
  end

  scenario 'an admin can see the list of static pages' do
    current_path.should == admin_static_pages_path

    within_table 'static_pages' do
      page.should have_content('Name')
      page.should have_content('Updated At')

      page.should have_selector('tbody tr', :count => 2)
    end
  end

  scenario 'an admin can edit a static page' do
    static_page = StaticPage.find_by_name(:about)

    within "#static_page_#{static_page.id}" do
      click_link 'Edit'
    end

    current_path.should == edit_admin_static_page_path(static_page, :locale => nil)
    within 'form#edit_static_page' do
      page.should have_field('Content')
      page.should have_button('Update Static page')

      fill_in 'Content', :with => 'New content'
      click_button 'Update Static page'
      static_page.reload
    end

    within '.flashes' do
      page.should have_content('Static page was successfully updated.')
    end

    current_path.should == admin_static_page_path(static_page, :locale => nil)
    page.should have_content('New content')
  end
end
