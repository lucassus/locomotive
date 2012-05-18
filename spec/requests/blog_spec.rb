require 'spec_helper'

feature 'Reading blog posts' do
  let!(:published_post) { create(:published_post) }

  background do
    visit root_path
    click_link 'Posts'
  end

  scenario 'an user can see the list of recent posts' do
    page.should have_content(published_post.title)
  end

  scenario 'an user can read a post' do
    click_link published_post.title
    page.should have_content(published_post.title)
  end
end
