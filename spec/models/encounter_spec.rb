require 'spec_helper'

describe Encounter do

  describe 'fields' do
    it { should have_db_column(:user_id).of_type(:integer) }
    it { should have_db_column(:other_user_id).of_type(:integer) }
    it { should have_db_column(:interest_type).of_type(:string) }

    it { should have_db_index(:user_id) }
    it { should have_db_index(:other_user_id) }
    it { should have_db_index(:interest_type) }
    it { should have_db_index([:user_id, :other_user_id]).unique(true) }
  end

  describe 'association' do
    it { should belong_to(:user) }
  end

end
