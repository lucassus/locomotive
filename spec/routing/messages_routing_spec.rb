require 'spec_helper'

describe 'Messages routing' do
  let(:path) { public_send(subject) }

  describe :messages_path do
    specify { path.should == '/messages' }
    specify { post(path).should route_to('messages#create') }
  end

  describe :new_message_path do
    specify { path.should == '/messages/new' }
    specify { get(path).should route_to('messages#new') }
  end

end
