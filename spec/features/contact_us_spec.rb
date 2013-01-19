require 'spec_helper'

feature 'Contact us form' do

  context 'when the user is not logged' do
    background do
      visit root_path
      click_link "Contact us"
    end

    scenario 'send an email' do
      within 'form#new_message' do
        fill_in 'Name', with: 'Luke Skywalker'
        fill_in 'Email', with: 'luke@rebel.com'
        fill_in 'Body', with: 'This is a simple message'

        click_button 'Send'
      end

      page.should display_flash_message('Message has been send')
      expect(current_path).to eq(root_path)

      open_email 'from@example.com'
      expect(current_email).to have_content('This is a simple message')
    end
  end

  context 'when the user is logged' do
    let!(:user) { create(:user, email: 'user@email.com') }

    background do
      login_with(user)
      visit root_path
      click_link "Contact us"
    end

    scenario 'pre-fill user name and email' do
      within 'form#new_message' do
        expect(find_field('message_email').value).to eq("user@email.com")

        fill_in 'Name', with: 'Luke Skywalker'
        fill_in 'Body', with: 'This is a simple message'

        click_button 'Send'
      end

      page.should display_flash_message('Message has been send')
      expect(current_path).to eq(root_path)

      open_email 'from@example.com'
      expect(current_email).to have_content('This is a simple message')
      expect(current_email).to have_content('user@email.com')
    end
  end

end
