shared_examples_for 'a model that has timestamp fields' do
  it { should have_db_column(:created_at).of_type(:datetime) }
  it { should have_db_column(:updated_at).of_type(:datetime) }
end

shared_examples_for 'a model that allows mass assignment for' do |*fields|
  fields.each do |field|
    it { should allow_mass_assignment_of(field) }
  end
end
