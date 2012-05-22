# Notes about testing

## Cove coverage

Run test code coverage with the following command:

    SIMPLECOV=1 rspec spec

The coverage result will be generated in `./reports/coverage` directory

## RSpec best practices

### Testing models

#### Database fields and indexes

See [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers) documentation:

* [have\_db\_column](http://rdoc.info/github/thoughtbot/shoulda-matchers/Shoulda/Matchers/ActiveRecord:have_db_column)
* [have\_db\_index](http://rdoc.info/github/thoughtbot/shoulda-matchers/Shoulda/Matchers/ActiveRecord:have_db_index)

Sample code:

    describe Person do

      describe 'fields' do
        it { should_not have_db_column(:admin).of_type(:boolean) }
        it { should have_db_column(:salary).
                      of_type(:decimal).
                      with_options(:precision => 10, :scale => 2) }

        it { should have_db_index(:age) }
        it { should have_db_index([:commentable_type, :commentable_id]) }
        it { should have_db_index(:ssn).unique(true) }
      end

    end

### Testing controllers

Turn off view rendering in a controller example group:

    RSpec.configure do |config|
      config.render_views = false
    end

Sample spec for the controller:

    describe PostsController do

      describe 'on GET to :index' do
        before do
          Post.should_receive(:recent).with(10).and_return([])
          get :index
        end

        it { should respond_with(:success) }
        it { should_not set_the_flash }
        it { should render_template(:index) }
        it { should assign_to(:posts) }
      end

      describe 'on GET to :show' do
        before do
          published = mock()
          published.should_receive(:find).with('123').and_return(mock_model(Post))
          Post.should_receive(:published).and_return(published)

          get :show, :id => '123'
        end

        it { should respond_with(:success) }
        it { should_not set_the_flash }
        it { should render_template(:show) }
        it { should assign_to(:post) }
      end

    end

### Testing routes

Sample spec for the routing

    describe 'Admin static page routing' do
      let(:path) { public_send(subject) }

      describe :admin_static_pages_path do
        specify { path.should == '/admin/static_pages' }
        specify { get(path).should route_to('admin/static_pages#index') }
        specify { post(path).should route_to('admin/static_pages#create') }
      end

      describe :admin_static_page_path do
        let(:id) { ':id' }
        let(:path) { admin_static_page_path(id, :locale => 'en') }

        specify { path.should == "/en/admin/static_pages/#{id}" }
        specify { get(path).should route_to('admin/static_pages#show', :id => id, :locale => 'en') }
        specify { put(path).should route_to('admin/static_pages#update', :id => id, :locale => 'en') }
        specify { delete(path).should route_to('admin/static_pages#destroy', :id => id, :locale => 'en') }
      end

      describe :new_admin_static_page_path do
        specify { path.should == '/admin/static_pages/new' }
        specify { get(path).should route_to('admin/static_pages#new') }
      end

      describe :edit_admin_static_page_path do
        let(:id) { ':id' }
        let(:path) { edit_admin_static_page_path(id, :locale => 'en') }

        specify { path.should == "/en/admin/static_pages/#{id}/edit" }
        specify { get(path).should route_to('admin/static_pages#edit', :id => id, :locale => 'en') }
      end

    end

Sample routing spec output;

    Admin static page routing
      admin_static_pages_path
        should == "/admin/static_pages"
        should route {:get=>"/admin/static_pages"} to {:controller=>"admin/static_pages", :action=>"index"}
        should route {:post=>"/admin/static_pages"} to {:controller=>"admin/static_pages", :action=>"create"}

      admin_static_page_path
        should == "/en/admin/static_pages/:id"
        should route {:get=>"/en/admin/static_pages/:id"} to {:id=>":id", :locale=>"en", :controller=>"admin/static_pages", :action=>"show"}
        should route {:put=>"/en/admin/static_pages/:id"} to {:id=>":id", :locale=>"en", :controller=>"admin/static_pages", :action=>"update"}
        should route {:delete=>"/en/admin/static_pages/:id"} to {:id=>":id", :locale=>"en", :controller=>"admin/static_pages", :action=>"destroy"}

### Request specs

TODO
