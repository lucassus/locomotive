require 'spec_helper'

describe UserAccount do

  describe 'fields' do
    it_behaves_like 'a model with the following database columns',
                    [:user_id, :integer, :null => false],
                    [:provider, :string, :limit => 16, :null => false],
                    [:uid, :string, :null => false],
                    [:token, :string],
                    [:auth_response, :text]

    it_behaves_like 'a model with timestampable columns'

    it { should have_db_index(:user_id) }
    it { should have_db_index([:user_id, :provider]).unique(true) }
    it { should have_foreign_key_for(:user, :dependent => :delete) }
  end

  it_behaves_like 'a model that allows mass assignment for',
                  :provider, :uid, :token, :auth_response

  describe 'associations' do
    it { should belong_to(:user) }
  end

end
