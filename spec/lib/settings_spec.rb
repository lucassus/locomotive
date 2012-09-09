require 'spec_models_helper'

describe Settings do

  its(:app_name) { should == 'Locomotive' }

end
