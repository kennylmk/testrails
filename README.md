# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
2.7.3


* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


# Instructions on how to build and run your app.
Installation

Install ruby
gem UPDATE
gem update --system

Install SQLite3
```
 gem install sqlite3-ruby
```

Install Node.js

Install yarn

install rails
```
gem install rails
```

Create new application
```
rails new score
```

Setup route


``` 
bundle exec rails s -p 3000 -b '0.0.0.0'
```
# Instruction on how to run unit and integration tests.
## Request Spects Test
```
bundle exec rspec spec/requests/score.spec.rb
```

## Model Spects Test

```
bundle exec rspec spec/model/score.spec
```
# Quick documentation of your API.
# (bonus/optional) a Docker compose setup that runs you app automatically