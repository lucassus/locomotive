require 'spec_helper'

describe User do
  subject { create(:user) }

  describe 'fields' do
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:sign_in_count).of_type(:integer) }
    it { should have_db_column(:admin).of_type(:boolean) }
    it { should have_db_column(:last_sign_in_at).of_type(:datetime) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
  end

  describe 'factories' do
    it { should have_valid_factory }
    it { should have_valid_factory(:admin_user) }
  end

  describe 'scopes' do
    describe '#admin' do
      let!(:first_admin) { create(:admin_user) }
      let!(:second_admin) { create(:admin_user) }
      before { 3.times { create(:user) } }

      subject { User.admin }

      it { should have(2).items }
      it { should include(first_admin) }
      it { should include(second_admin) }
    end
  end
end
