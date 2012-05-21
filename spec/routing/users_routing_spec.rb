require "spec_helper"

describe 'Users routing' do
  let(:path) { public_send(subject) }

  describe :new_user_registration_path  do
    specify { path.should == '/users/sign_up' }
    specify { get(path).should route_to('devise/registrations#new') }
  end

  describe :new_user_session_path do
    specify { path.should == '/users/sign_in' }
    specify { get(path).should route_to('devise/sessions#new') }
    specify { post(path).should route_to('devise/sessions#create') }
  end

  describe :destroy_user_session_path do
    specify { path.should == '/users/sign_out' }
    specify { delete(path).should route_to('devise/sessions#destroy') }
  end

  describe :edit_user_registration_path  do
    specify { path.should == '/users/edit' }
    specify { get(path).should route_to('devise/registrations#edit') }
  end

end
