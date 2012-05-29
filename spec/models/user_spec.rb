require 'spec_helper'

describe User do
  subject { create(:user) }

  describe 'fields' do
    it_behaves_like 'a model with the following database columns',
                    [:email, :string],
                    [:sign_in_count, :integer],
                    [:admin, :boolean, :default => false, :null => false],
                    [:suspended, :boolean, :default => false, :null => false],
                    [:last_sign_in_at, :datetime]

    it_behaves_like 'a model with timestampable columns'
  end

  it_behaves_like 'a model that allows mass assignment for',
                  :email, :password, :password_confirmation, :remember_me,
                  :suspended

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
      let!(:first_admin) { create(:user, :admin) }
      let!(:second_admin) { create(:user, :admin) }

      subject { User.admin }

      it { should have(2).items }
      it { should include(first_admin) }
      it { should include(second_admin) }
    end

    describe '#suspended' do
      let!(:suspended_user) { create(:user, :suspended) }

      subject { User.suspended }

      it { should have(1).item }
      it { should include(suspended_user) }
    end
  end

  # TODO try dry it with shared examples
  describe 'accounts' do
    context 'facebook' do
      context 'when an user has an account' do
        let!(:account) { create(:user_account, :facebook, :user => subject) }

        it { should be_connected_to_facebook }
        its(:facebook_account) { should_not be_nil }
        its(:facebook_account) { should == account }
      end

      context 'otherwise' do
        it { should_not be_connected_to_facebook }
        its(:facebook_account) { should be_nil }
      end
    end

    context 'twitter' do
      context 'when an user an account' do
        let!(:account) { create(:user_account, :twitter, :user => subject) }

        it { should be_connected_to_twitter }
        its(:twitter_account) { should_not be_nil }
        its(:twitter_account) { should == account }
      end

      context 'otherwise' do
        it { should_not be_connected_to_twitter }
        its(:twitter_account) { should be_nil }
      end
    end
  end
end
