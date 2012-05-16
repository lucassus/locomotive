require 'spec_helper'

describe Post do

  describe 'fields' do
    it { should have_db_column(:title).of_type(:string).with_options(:null => false) }
    it { should have_db_column(:body).of_type(:text) }
    it { should have_db_column(:published).of_type(:boolean).with_options(:null => false, :default => false) }

    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
  end

  describe 'scopes' do
    describe '.published' do
      let!(:first_published_post) { create(:published_post) }
      let!(:second_published_post) { create(:published_post) }
      let!(:post) { create(:post) }

      subject { Post.published }

      it { should have(2).items }
      it { should include(first_published_post) }
      it { should include(second_published_post) }
      it { should_not include(post) }
    end
  end

end
