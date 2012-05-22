require 'spec_helper'

describe 'Static pages routing' do

  describe :static_page_path do
    let(:id) { ':id' }
    let(:path) { static_page_path(id, :locale => 'en') }

    specify { path.should == "/en/pages/#{id}" }
    specify { get(path).should route_to('static_pages#show', :id => id, :locale => 'en') }
  end

end
