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

end
