require 'spec_helper'

describe User do
  subject { create(:user) }

  describe 'fields' do
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:sign_in_count).of_type(:integer) }

    it { should have_db_column(:gender).of_type(:string) }
    it { should have_db_column(:age).of_type(:integer) }

    it { should have_db_column(:admin).of_type(:boolean) }
    it { should have_db_column(:last_sign_in_at).of_type(:datetime) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'associations' do
    it { should have_many(:encounters).dependent(:destroy) }
    it { should have_many(:willing_to_meet_users).through(:encounters) }

    describe '#willing_to_meet_users' do
      let!(:user) { create(:user) }

      let!(:first_user) { create(:user) }
      let!(:second_user) { create(:user) }
      let!(:not_popular_user) { create(:user) }

      before do
        create(:encounter, :user => user, :other_user => first_user)
        create(:encounter, :user => user, :other_user => second_user)
      end

      subject { user.willing_to_meet_users }

      it { should have(2).items }
      it { should include(first_user) }
      it { should include(second_user) }
    end
  end

  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
  end

  describe 'factories' do
    specify { build(:user).should be_valid }
    specify { build(:admin_user).should be_valid }
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
