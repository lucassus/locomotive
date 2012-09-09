require 'spec_helper'

describe 'Admin static page routing' do
  let(:path) { public_send(subject) }

  describe :admin_static_pages_path do
    specify { path.should == '/admin/static_pages' }
    specify { get(path).should route_to('admin/static_pages#index') }
  end

  describe :admin_static_page_path do
    let(:id) { ':id' }
    let(:path) { admin_static_page_path(id, :locale => 'en') }

    specify { path.should == "/en/admin/static_pages/#{id}" }
    specify { get(path).should route_to('admin/static_pages#show', :id => id, :locale => 'en') }
    specify { put(path).should route_to('admin/static_pages#update', :id => id, :locale => 'en') }
  end


  describe :edit_admin_static_page_path do
    let(:id) { ':id' }
    let(:path) { edit_admin_static_page_path(id, :locale => 'en') }

    specify { path.should == "/en/admin/static_pages/#{id}/edit" }
    specify { get(path).should route_to('admin/static_pages#edit', :id => id, :locale => 'en') }
  end

end
