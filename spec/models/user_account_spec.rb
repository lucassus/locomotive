require 'spec_helper'

describe UserAccount do

  describe 'fields' do
    it { should have_db_column(:user_id).of_type(:integer).with_options(:null => false) }
    it { should have_db_column(:provider).of_type(:string).with_options(:limit => 16, :null => false) }
    it { should have_db_column(:uid).of_type(:string).with_options(:null => false) }
    it { should have_db_column(:token).of_type(:string) }
    it { should have_db_column(:auth_response).of_type(:text) }

    it_behaves_like 'a model that has timestamp fields'

    it { should have_db_index(:user_id) }
    it { should have_db_index([:user_id, :provider]).unique(true) }
  end

  it_behaves_like 'a model that allows mass assignment for',
                  :provider, :uid, :token, :auth_response

  describe 'associations' do
    it { should belong_to(:user) }
  end

end
