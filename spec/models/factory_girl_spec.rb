require 'spec_helper'

describe FactoryGirl do
  FactoryGirl.factories.each do |factory|
    context "with factory for :#{factory.name}" do
      subject { FactoryGirl.build(factory.name) }

      it "is valid" do
        expect(subject.valid?).to be_true
      end
    end
  end
end
