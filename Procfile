web:    bundle exec rails server thin -p $PORT
log:    tail -f log/development.log
worker: bundle exec rake environment resque:work QUEUE=*
