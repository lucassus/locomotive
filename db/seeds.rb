# Create first user account
user = User.new do |u|
  u.email 'user@email.com'
  u.password = u.password_confirmation = 'password'
end
user.save!
