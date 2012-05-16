require 'spec_helper'

feature 'Locale switcher' do
  shared_context 'with locale' do |locale|
    before do
      visit root_path

      within '.dropdown-menu.locale' do
        click_link locale.to_s
      end
    end
  end

  describe 'switch to :en locale' do
    include_context 'with locale', :en

    scenario 'locale should be set to :en' do
      I18n.locale.should == :en
    end
  end

  describe 'switch to :de locale' do
    include_context 'with locale', :pl

    scenario 'locale should be set to :pl' do
      I18n.locale.should == :pl
    end
  end
end
