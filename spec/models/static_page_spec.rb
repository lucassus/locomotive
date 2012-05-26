require 'spec_helper'

describe StaticPage do

  describe 'fields' do
    it { should have_db_column(:name).of_type(:string).with_options(:null => false) }
    it { should have_db_column(:content).of_type(:text) }

    it_behaves_like 'a model that has timestamp fields'

    it { should have_db_index(:name).unique(true) }
  end

  it_behaves_like 'a model that allows mass assignment for', :content

end
