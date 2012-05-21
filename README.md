# Locomotive, Rails base application

[![Build status](https://secure.travis-ci.org/lucassus/locomotive.png)](http://travis-ci.org/lucassus/locomotive)

Base Rails application.

## Quick start

Clone application as new project with original repository named `base-app`

    git clone git://github.com/fs/rails3-base.git --origin base-app [MY-NEW-PROJECT]

Create your new repo on GitHub and push master into it. Make sure master branch is tracking origin repo.

    git remote add origin git@github.com:[MY-GITHUB-ACCOUNT]/[MY-NEW-PROJECT].git
    git push -u origin master

Setup configuration files

    cp config/database.yml.example config/database.yml

Install gems and enable rvm integration with Bundler (the “bin” directory is added to your path each time you cd into a project directory with binstubs)

    bundle install --path vendor --binstubs
    chmod +x $rvm_path/hooks/after_cd_bundler

Run migrations and prepare test database

    rake db:migrate
    rake db:test:prepare

Make sure all tests are green

    rspec spec

Optionally you can seed the development database with sample data

    rake db:seed

..and finally generate project documentation

    bundle exec yard doc

(documentation will be generated in `./tmp/doc' folder)

## Implemented core features

* basic users authentication with Devise
* simple frontend made with twitter bootstrap
* activeadmin panel with customized section for managing users
* preconfigured rspec along with factory_girl, capybara and should matchers
* ready for deploy on heroku (gem: heroku_san)
