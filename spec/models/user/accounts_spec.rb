require 'spec_helper'

describe User::Accounts do
  subject { create(:user) }

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
