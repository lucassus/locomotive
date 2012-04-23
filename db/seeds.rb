# Create admin user
admin_user = User.new do |u|
  u.email = 'admin@email.com'
  u.password = u.password_confirmation = 'password'
  u.admin = true
end
admin_user.save!

# Create first user account
user = User.new do |u|
  u.email = 'user@email.com'
  u.password = u.password_confirmation = 'password'
end
user.save!
