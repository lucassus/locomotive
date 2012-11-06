require 'spec_helper'

describe ApplicationHelper do

  describe "#flash_messages" do
    context "when there is no flash messages" do
      it "should return nothing" do
        helper.flash_messages.should be_nil
      end
    end

    context "when there are some flash messages" do
      let(:flashes) do
        Hash.new.tap do |messages|
          messages[:notice] = 'Battle station operational'
          messages[:error] = 'Hudson, we have a problem!'
          messages[:warning] = "I'm sorry Dave, I'm afraid I can't do that"
        end
      end

      before do
        flashes.each { |type, message| flash[type] = message }
      end

      subject { helper.flash_messages }

      it "should render flash messages container" do
        should have_selector("div.flash")
      end

      it "should render a list with flash messages" do
        flashes.each do |type, message|
          should have_selector("div.alert.alert-#{type}", text: message)
        end
      end
    end
  end

end
