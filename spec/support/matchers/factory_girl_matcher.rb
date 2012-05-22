# Usage:
#
# describe User do
#   it { should have_valid_factory }
#   it { should have_valid_factory(:admin_user) }
# end
RSpec::Matchers.define :have_valid_factory do |factory_name = nil|
  match do
    factory_name ||= subject.class.to_s.underscore.to_sym
    record = FactoryGirl.build(factory_name)

    raise record.errors.inspect unless record.valid?
    record.save && record.instance_of?(subject.class)
  end

  description do
    "have #{factory_name.inspect} factory"
  end
end
