# Notes about testing

## Cove coverage

Run test code coverage with the following command: `SIMPLECOV=1 rspec spec/`

The coverage result will be generated in `./results/coverage` directory

## RSpec best practices

### Testing models

#### Database fields and indexes

See [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers) documentation:

* [have\_db\_column](http://rdoc.info/github/thoughtbot/shoulda-matchers/Shoulda/Matchers/ActiveRecord:have_db_column)
* [have\_db\_index](http://rdoc.info/github/thoughtbot/shoulda-matchers/Shoulda/Matchers/ActiveRecord:have_db_index)

Sample code:

    describe Person do

      describe 'fields' do
        it { should_not have_db_column(:admin).of_type(:boolean) }
        it { should have_db_column(:salary).
                      of_type(:decimal).
                      with_options(:precision => 10, :scale => 2) }

        it { should have_db_index(:age) }
        it { should have_db_index([:commentable_type, :commentable_id]) }
        it { should have_db_index(:ssn).unique(true) }
      end

    end

### Testing controllers

TODO

### Testing routes

TODO

### Request specs

TODO
