require 'spec_helper'

feature 'An user can see the static page' do
  let!(:about_page) { create(:static_page, :name => :about, :content => "## This is the static page") }

  background do
    visit root_path
  end

  scenario 'show the page' do
    click_link 'About'

    current_path.should == "/pages/#{about_page.name}"

    within 'h2' do
      page.should have_content('This is the static page')
    end
  end
end
