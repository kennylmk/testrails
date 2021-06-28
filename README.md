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
## Setup
### Install all gems:
```
$ bundle install
```

### Install ruby
2.7.3 onwards 

https://rubyinstaller.org/

```
sudo apt-get install ruby-full

```

### gem UPDATE
2.7.3
```
gem update --system

```


### Install SQLite3


```
 gem install sqlite3-ruby
```

Install Node.js

Install yarn

###I nstall rails

```
gem install rails
```

Create new application
```
rails new score
```


## Usage
|Http   | Paths | Controller#Action|Used for|
|-|-|-|-|
|GET | /scores|scores#index|List all the records|
|POST | /scores/:id |scores#create| Create record ????|
|GET|/scores/:id|scores#show| display a specific score record|
|PUT | /scores/:id | scores#update|Update record|
|DELETE | /scores/:id |scores#destroy| Delete record|
|GET|/scores/history|scores#history| Get History score of the player|
|GET|/scores/list|scores#list| Query Score data|


Create a new record
$ curl -X POST -H 'Content-Type: application/jsoo' -d '{"player":}'


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
