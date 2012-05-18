require 'spec_helper'

feature 'Admin can manage posts' do
  let!(:admin_user) { create(:admin_user) }

  background do
    3.times { create(:published_post) }
    2.times { create(:unpublished_post) }
    login_with(admin_user)

    visit admin_dashboard_path
    click_link 'Posts'
  end

  scenario 'an admin can see the list of posts' do
    current_path.should == admin_posts_path

    within_table 'posts' do
      page.should have_content('Title')
      page.should have_content('Published')
      page.should have_content('Created At')

      page.should have_selector('tbody tr', :count => 5)
    end

    within 'ul.scopes' do
      click_link 'Published'
    end

    within_table 'posts' do
      page.should have_css('tbody tr', :count => 3)
    end

    within 'ul.scopes' do
      click_link 'Unpublished'
    end

    within_table 'posts' do
      page.should have_css('tbody tr', :count => 2)
    end
  end

  scenario 'an admin can create a post' do
    click_link 'New Post'

    current_path.should == new_admin_post_path(:locale => nil)

    within 'form#new_post' do
      fill_in 'Title', :with => 'This is the new post'
      fill_in 'Body', :with => 'This is the new post body'
      check 'Published'

      click_button 'Create Post'
    end

    page.should have_content('Post was successfully created.')
    page.should have_content('This is the new post')
  end

  scenario 'an admin can edit a post' do
    post = Post.last

    within "#post_#{post.id}" do
      click_link 'Edit'
    end

    current_path.should == edit_admin_post_path(post, :locale => nil)
    within 'form#edit_post' do
      page.should have_field('Title', :with => post.title)
      page.should have_field('Body')
      page.should have_field('Published', :with => post.published)
      page.should have_button('Update Post')

      fill_in 'Title', :with => 'New post title'
      click_button 'Update Post'
    end

    within '.flashes' do
      page.should have_content('Post was successfully updated.')
    end

    current_path.should == admin_post_path(post, :locale => nil)
    page.should have_content('New post title')
  end
end
