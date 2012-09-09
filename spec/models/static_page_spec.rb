require 'spec_models_helper'

describe StaticPage do

  describe 'fields' do
    it_behaves_like 'a model with the following database columns',
                    [:name, :string, :null => false],
                    [:content, :text]

    it_behaves_like 'a model with timestampable columns'

    it { should have_db_index(:name).unique(true) }
  end

  it_behaves_like 'a model that allows mass assignment for', :content

end
