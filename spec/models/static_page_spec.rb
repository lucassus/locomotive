require 'spec_helper'

describe StaticPage do

  describe 'fields' do
    it { should have_db_column(:name).of_type(:string).with_options(:null => false) }
    it { should have_db_column(:content).of_type(:text) }

    it_behaves_like "a model that has timestamp fields"

    it { should have_db_index(:name) .unique(true) }
  end

  describe 'mass assignment' do
    it { should allow_mass_assignment_of(:content) }
  end

  describe 'mass assignment' do
    it { should allow_mass_assignment_of(:content) }
  end

end
