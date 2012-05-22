require 'spec_helper'

describe UserAccount do

  describe 'fields' do
    it { should have_db_column(:user_id).of_type(:integer).with_options(:null => false) }
    it { should have_db_column(:provider).of_type(:string).with_options(:limit => 16, :null => false) }
    it { should have_db_column(:uid).of_type(:string).with_options(:null => false) }
    it { should have_db_column(:token).of_type(:string) }
    it { should have_db_column(:auth_response).of_type(:text) }

    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }

    it { should have_db_index(:user_id) }
    it { should have_db_index([:user_id, :provider]).unique(true) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'factories' do
    it { should have_valid_factory }
    it { should have_valid_factory(:facebook_account) }
    it { should have_valid_factory(:twitter_account) }
  end

end
