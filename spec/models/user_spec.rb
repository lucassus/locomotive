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
    let!(:user) { create(:user) }
    let!(:first_user) { create(:user) }
    let!(:second_user) { create(:user) }
    let!(:not_popular_user) { create(:user) }

    it { should have_many(:encounters).dependent(:destroy) }
    it { should have_many(:willing_to_meet_users).through(:encounters) }
    it { should have_many(:want_to_meet_users).through(:encounters) }

    it { should have_many(:encounters_reverse).dependent(:destroy) }
    it { should have_many(:willing_to_meet_me_users).through(:encounters_reverse) }

    describe '#willing_to_meet_users' do
      before do
        create(:encounter, :user => user, :other_user => first_user)
        create(:encounter, :user => user, :other_user => second_user)
      end

      subject { user.willing_to_meet_users }

      it { should have(2).items }
      it { should include(first_user) }
      it { should include(second_user) }
      it { should_not include(user) }
      it { should_not include(not_popular_user) }
    end

    describe '#want_to_meet_users' do
      before do
        create(:encounter, :user => user, :other_user => first_user, :interest_type => :meet_yes)
        create(:encounter, :user => user, :other_user => second_user, :interest_type => :meet_maybe)
      end

      subject { user.want_to_meet_users }

      it { should have(1).items }
      it { should include(first_user) }
      it { should_not include(second_user) }
      it { should_not include(user) }
      it { should_not include(not_popular_user) }
    end

    describe '#willing_to_meet_me_users' do
      before do
        create(:encounter, :user => first_user, :other_user => user)
        create(:encounter, :user => not_popular_user, :other_user => user)
      end

      subject { user.willing_to_meet_me_users }

      it { should have(2).items }
      it { should include(first_user) }
      it { should include(not_popular_user) }
      it { should_not include(user) }
      it { should_not include(second_user) }
    end

    describe '#want_to_meet_me_users' do
      before do
        create(:encounter, :user => first_user, :other_user => user, :interest_type => :meet_yes)
        create(:encounter, :user => not_popular_user, :other_user => user, :interest_type => :meet_not)
      end

      subject { user.want_to_meet_me_users }

      it { should have(1).items }
      it { should include(first_user) }
      it { should_not include(not_popular_user) }
      it { should_not include(user) }
      it { should_not include(second_user) }
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

    describe '#not_encountered_users' do
      let!(:user) { create(:user) }

      let!(:first_user) { create(:user) }
      let!(:second_user) { create(:user) }
      let!(:third_user) { create(:user) }

      context 'when the user has no encounters' do
        subject { user.not_encountered_users }

        it { should have(3).items }
        it { should include(first_user) }
        it { should include(second_user) }
        it { should include(third_user) }
        it { should_not include(user) }
      end

      context 'when the user has several encounters' do
        let!(:yet_another_user) { create(:user) }

        before do
          create(:encounter, :user => user, :other_user => first_user)
          create(:encounter, :user => user, :other_user => second_user)
        end

        subject { user.not_encountered_users }
        it { should have(2).items }
        it { should include(third_user) }
        it { should include(yet_another_user) }
        it { should_not include(user) }
        it { should_not include(first_user) }
        it { should_not include(second_user) }
      end
    end
  end

  describe "#want_to_meet_me?" do
    let!(:other_user) { create(:user) }
    let!(:not_popular_user) { create(:user) }

    before { create(:encounter, :user => other_user, :other_user => subject, :interest_type => :meet_yes) }

    it 'should return true if the other user want to meet the user' do
      subject.want_to_meet_me?(other_user).should be_true
      subject.want_to_meet_me?(not_popular_user).should be_false
    end
  end
end
