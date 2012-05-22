require 'spec_helper'

describe 'User accounts routing' do
  let(:path) { public_send(subject) }

  describe :user_accounts_path  do
    specify { path.should == '/user_accounts' }
    specify { get(path).should route_to('user_accounts#index') }
    specify { post(path).should route_to('user_accounts#create') }
  end

  describe :user_account_path do
    let(:id) { ':id' }
    let(:path) { user_account_path(id, :locale => 'en') }

    specify { path.should == "/en/user_accounts/#{id}" }
    specify { delete(path).should route_to('user_accounts#destroy', :id => id, :locale => 'en') }
  end

end
