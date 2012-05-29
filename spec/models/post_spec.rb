require 'spec_helper'

describe Post do

  describe 'database columns' do
    it_behaves_like 'a model with the following database columns',
                    [:title, :string, :null => false],
                    [:body, :text],
                    [:published, :boolean, :null => false, :default => false]

    it_behaves_like 'a model with timestampable columns'
  end

  it_behaves_like 'a model that allows mass assignment for',
                  :title, :body, :published

  describe 'validations' do
    it { should validate_presence_of(:title) }
  end

  describe 'scopes' do
    let!(:first_published_post) { create(:post, :published, :created_at => 1.day.ago) }
    let!(:second_published_post) { create(:post, :published) }
    let!(:unpublished_post) { create(:post, :unpublished) }

    describe '.published' do
      subject { Post.published }

      it { should have(2).items }
      it { should include(first_published_post) }
      it { should include(second_published_post) }
      it { should_not include(unpublished_post) }
    end

    describe '.unpublished' do
      subject { Post.unpublished }

      it { should have(1).item }
      it { should include(unpublished_post) }
    end

    describe '.recent' do
      subject { Post.recent(2) }

      it { should have(2).items }
      its(:first) { should == second_published_post }
      its(:second) { should == first_published_post }
    end
  end

  describe '#to_param' do
    let(:id) { 666 }
    let(:title) { 'Sample post title?!' }
    subject { create(:post, :id => id, :title => title) }

    it 'should include post id at the beginning' do
      subject.to_param.should match /^#{id}/
    end

    it 'should include escaped post title' do
      subject.to_param.should == '666-sample-post-title'
    end
  end

end
