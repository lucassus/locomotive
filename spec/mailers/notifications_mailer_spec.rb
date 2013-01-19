require 'spec_helper'

describe NotificationsMailer do

  describe '.contact_us' do
    let(:message) { Message.new(name: 'Luke Skylwaker', email: 'luke@rebel.com', body: 'This is body') }

    it 'should render an email successfully' do
      lambda { NotificationsMailer.contact_us(message) }.should_not raise_error
    end

    describe 'rendered email' do
      subject { NotificationsMailer.contact_us(message) }

      its(:subject) { should == 'Contact us form' }
      its(:from) { should == ['from@example.com'] }
      its(:to) { should == ['from@example.com'] }

      its(:body) { should_not be_empty }
      its(:body) { should include("Luke Skylwaker") }
      its(:body) { should include("luke@rebel.com") }
      its(:body) { should include("This is body") }

      it 'should be added to the delivery queue' do
        lambda { subject.deliver }.should change(ActionMailer::Base.deliveries, :size).by(1)
      end
    end
  end

end
