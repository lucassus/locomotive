require 'spec_helper'

describe 'User sign out feature' do

  before do
    user = create(:user, :email => 'user@email.com')
    login_with(user)

    visit root_path
    click_link 'Sign out'
  end

  it 'should display flash message' do
    page.should have_content('Signed out successfully.')
  end

  it 'should redirect to the home page' do
    current_path.should == root_path
  end

end
