require 'spec_models_helper'

describe User do
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
    subject(:user) { create(:user) }

    it { should have_many(:accounts) }

    describe 'on delete' do
      before do
        create(:user_account, :facebook, user: user)
        create(:user_account, :twitter, user: user)
      end

      it 'should delete associated images' do
        expect do
          user.destroy
        end.to change(UserAccount, :count).by(-2)
      end
    end
  end

  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
  end

  describe 'scopes' do
    let!(:first_user) { create(:user) }
    let!(:second_user) { create(:user) }
    let!(:third_user) { create(:user) }

    describe '.admin' do
      before do
        first_user.update_column(:admin, true)
        third_user.update_column(:admin, true)
      end

      subject { User.admin }

      it 'should return only admin users' do
        should have(2).items
        should include(first_user)
        should include(third_user)
        should_not include(second_user)
      end
    end

    describe '.suspended' do
      before do
        first_user.update_column(:suspended, true)
        second_user.update_column(:suspended, true)
      end

      subject { User.suspended }

      it 'should return only suspended users' do
        should have(2).items
        should include(first_user)
        should include(second_user)
        should_not include(third_user)
      end
    end
  end
end
