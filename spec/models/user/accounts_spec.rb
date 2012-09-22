require 'spec_models_helper'

describe User::Accounts do
  let(:user) { create(:user) }
  subject { user }

  shared_examples_for 'an user connected to' do |account_type|
    specify { subject.connected_to?(account_type).should be_true }
    it { should public_send("be_connected_to_#{account_type}") }

    its(:"#{account_type}_account") { should_not be_nil }
    its(:"#{account_type}_account") { should == account }
  end

  shared_examples_for 'an user not connected to' do |account_type|
    specify { subject.connected_to?(account_type).should be_false }
    it { should_not public_send("be_connected_to_#{account_type}") }

    its(:"#{account_type}_account") { should be_nil }
  end

  context 'facebook' do
    context 'when an user has an account' do
      let!(:account) { create(:user_account, :facebook, :user => subject) }
      it_behaves_like 'an user connected to', :facebook
    end

    context 'when an user does not have an account' do
      it_behaves_like 'an user not connected to', :facebook
    end
  end

  context 'twitter' do
    context 'when an user an account' do
      let!(:account) { create(:user_account, :twitter, :user => subject) }
      it_behaves_like 'an user connected to', :twitter
    end

    context 'when an user does not have an account' do
      it_behaves_like 'an user not connected to', :twitter
    end
  end

  context 'google' do
    context 'when an user an account' do
      let!(:account) { create(:user_account, :google, :user => subject) }
      it_behaves_like 'an user connected to', :google
    end

    context 'when an user does not have an account' do
      it_behaves_like 'an user not connected to', :google
    end
  end

  describe '#connect_to!' do
    context 'when an user is not connected' do
      describe 'connected account' do
        subject { user.connect_to!('google', { :uid => 'google-id' }) }

        it { should_not be_nil }
        its(:provider) { should == 'google' }
        its(:uid) { should == 'google-id' }
      end
    end

    context 'when an user is already connected' do
      before { create(:user_account, :twitter, :user => subject) }

      it 'should raise an exception' do
        expect do
          subject.connect_to!('facebook', {})
        end.to raise_error
      end
    end
  end
end
