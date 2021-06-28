### This is an API project which run on Ruby on rails to keep track the score of the player. 

# Setup
* Install all gems:
```
$ bundle install
```

* Install ruby
https://rubyinstaller.org/

```
sudo apt-get install ruby-full

```

* Install SQLite3


```
 gem install sqlite3-ruby
```

*  Install Node.js

* Install yarn

* Install rails

```
gem install rails
```

### Create new application

```
rails new score
```

### Generate Controller
```
rails generate controller scores index --skip-routes
```

### Generate Model
```
rails generate model score player:string score:integer time:datetime 
rails db:migrate
```
### Start up server

``` 
bundle exec rails s -p 3000 -b '0.0.0.0'
```

# Testing
## Request Spec Test
```
bundle exec rspec spec/requests/score.spec.rb
```

## Model Spec Test

```
bundle exec rspec spec/model/score.spec
```
# Usage
|Http   | Paths | Controller#Action|Used for|
|-|-|-|-|
|GET | /scores|scores#index|List all the records|
|POST | /scores/:id |scores#create| Create record ????|
|GET|/scores/:id|scores#show| display a specific score record|
|PUT | /scores/:id | scores#update|Update record|
|DELETE | /scores/:id |scores#destroy| Delete record|
|GET|/scores/history(.:format)|scores#history| Get History score of the player|
|GET|/scores/list(.:format)|scores#list| Query Score data|


Create a new record:

```
$ curl -X POST -H 'Content-Type: application/json' -d '{"player":"player1", "score":"1", "time":"2021-06-04 14:00"}' http://0.0.0.0:3000/scores
```

Update an existing record by id:
```
$ curl -X PUT -H 'Content-Type: application/json' -d  '{"score": "19"}' http://0.0.0.0:3000/scores/11
```

Delete an existing record by id:
```
$ curl -X DELETE -H 'Content-Type: application/json'  http://0.0.0.0:3000/scores/11
```
## Get list of scores
Pagination is implemented in this API and default to page 1 per 10 records if you don't add the page into query string.

### Get all scores by playerX
```
$ curl http://0.0.0.0:3000/scores/list?player=test&page=1
```
### Get all score after 1st November 2020
```
$ curl http://0.0.0.0:3000/scores/list?end=2020-11-01
```
### Get all scores by player1, player2 and player3 before 1st december 2020
```
$ curl http://0.0.0.0:3000/scores/list?player[]=test1&player[]=test2&end=2020-12-01
```
### Get all scores after 1 Jan 2020 and before 1 Jan 2021
```
$ curl http://0.0.0.0:3000/scores/list?start=2020-11-01&end=2020-12-01
```

## Get players' history
### top score (time and score) which the best ever score of the player.
```
$ curl http://0.0.0.0:3000/scores/history?query=top&player=test1
```
### low score (time and score) worst score of the player.
```
$ curl http://0.0.0.0:3000/scores/history?query=low&player=test1
```
### average score value for player
```
$ curl http://0.0.0.0:3000/scores/history?query=average&player=test1
```
### list of all the scores (time and score) of this player.
```
$ curl http://0.0.0.0:3000/scores/history?player=test1
```

# Docker 

Build docker
```
docker build -t score-image .
```

Run docker
```
docker run -p 3000:3000 -d score-image
curl http://0.0.0.0:3000/scores

```




## docker-compose start up
```
$ docker-compose -f docker-compose.yml up --build
```

## docker-compose shut down
```
$ docker-compose down -v
```