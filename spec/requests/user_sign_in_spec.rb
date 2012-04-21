require 'spec_helper'

describe 'User sign in feature' do

  before do
    create(:user, :email => 'user@email.com')

    visit root_path
    click_link 'Sign in'
    fill_in 'Email', :with => 'user@email.com'
    fill_in 'Password', :with => 'password'
    click_button 'Sign in'
  end

  it 'should display flash message' do
    page.should have_content('Signed in successfully.')
  end

  it 'should redirect to the home page' do
    current_path.should == root_path
  end

  it 'should display "Sing out"' do
    page.should have_link('Sign out')
  end

end
