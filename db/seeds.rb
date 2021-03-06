# Create admin user
admin_user = User.find_or_create_by_email('admin@email.com') do |u|
  u.password = u.password_confirmation = 'password'
  u.admin = true
end
admin_user.save!

# Create first user account
user = User.find_or_create_by_email('user@email.com') do |u|
  u.password = u.password_confirmation = 'password'
end
user.save!

if Rails.env.development?
  20.times { FactoryGirl.create(:user) }
end
