require 'spec_helper'

describe FactoryGirl do
  FactoryGirl.factories.each do |factory|
    context "with factory for :#{factory.name}" do
      subject { FactoryGirl.build(factory.name) }

      it "is valid" do
        subject.valid?.should be, subject.errors.full_messages
      end
    end
  end
end
