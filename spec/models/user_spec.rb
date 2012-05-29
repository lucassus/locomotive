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

  describe 'accounts' do

    shared_examples_for 'an user connected to' do |account_type|
      it { should public_send("be_connected_to_#{account_type}") }
      its(:"#{account_type}_account") { should_not be_nil }
      its(:"#{account_type}_account") { should == account }
    end

    shared_examples_for 'an user not connected to' do |account_type|
      it { should_not public_send("be_connected_to_#{account_type}") }
      its(:"#{account_type}_account") { should be_nil }
    end

    context 'facebook' do
      context 'when an user has an account' do
        let!(:account) { create(:user_account, :facebook, :user => subject) }
        it_behaves_like 'an user connected to', :facebook
      end

      context 'otherwise' do
        it_behaves_like 'an user not connected to', :facebook
      end
    end

    context 'twitter' do
      context 'when an user an account' do
        let!(:account) { create(:user_account, :twitter, :user => subject) }
        it_behaves_like 'an user connected to', :twitter
      end

      context 'otherwise' do
        it_behaves_like 'an user not connected to', :twitter
      end
    end
  end
end
