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
  require 'progress_bar'

  n = 10_000
  bar = ProgressBar.new(n)
  n.times do
    Factory.create(:user)
    bar.increment!
  end
end
