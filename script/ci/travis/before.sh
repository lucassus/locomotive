# Create a database.yml
echo "Setting up database.yml"
cp config/database.yml.example config/database.yml

# Set up database
echo "Creating database and loading schema"
bundle exec rake db:create --trace
bundle exec rake db:schema:load --trace
