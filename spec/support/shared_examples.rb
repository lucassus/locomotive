shared_examples_for 'a model that allows mass assignment for' do |*fields|
  fields.each do |field|
    it { should allow_mass_assignment_of(field) }
  end
end

shared_examples_for 'presence of' do |property|
  it "requires a value for #{property}" do
    record = described_class.new
    record.send(:"#{property}=", nil)
    record.should_not be_valid
    record.errors[property.to_sym].should include("can't be blank")
  end
end

shared_examples_for 'a model with the following database columns' do |*columns|
  columns.each do |column|
    it do
      name, type, options = *column

      have_this_column = have_db_column(name)
      have_this_column.of_type(type) if type.present?
      have_this_column.with_options(options) if options.present? and options.is_a?(Hash)

      should have_this_column
    end
  end
end

shared_examples_for 'a model with timestampable columns' do
  it { should have_db_column(:created_at).of_type(:datetime) }
  it { should have_db_column(:updated_at).of_type(:datetime) }
end
