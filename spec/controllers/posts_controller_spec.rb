require 'spec_helper'

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
