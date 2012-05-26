require 'spec_helper'

describe User do
  subject { create(:user) }

  describe 'fields' do
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:sign_in_count).of_type(:integer) }
    it { should have_db_column(:admin).of_type(:boolean).with_options(:default => false) }
    it { should have_db_column(:suspended).of_type(:boolean).with_options(:default => false) }
    it { should have_db_column(:last_sign_in_at).of_type(:datetime) }

    it_behaves_like "a model that has timestamp fields"
  end

  describe 'mass assignment' do
    it { should allow_mass_assignment_of(:email) }
    it { should allow_mass_assignment_of(:password) }
    it { should allow_mass_assignment_of(:password_confirmation) }
    it { should allow_mass_assignment_of(:remember_me) }
    it { should allow_mass_assignment_of(:suspended) }
  end

  describe 'associations' do
    it { should have_many(:accounts) }
  end

  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
  end

  describe 'scopes' do
    before { 3.times { create(:user) } }

    describe '#admin' do
      let!(:first_admin) { create(:admin_user) }
      let!(:second_admin) { create(:admin_user) }

      subject { User.admin }

      it { should have(2).items }
      it { should include(first_admin) }
      it { should include(second_admin) }
    end

    describe '#suspended' do
      let!(:suspended_user) { create(:user, :suspended => true) }

      subject { User.suspended }

      it { should have(1).item }
      it { should include(suspended_user) }
    end
  end
end
