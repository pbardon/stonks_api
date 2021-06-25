# Stonks API

This project is used to search and populate historical daily price data for US stocks. It consumes the following API in order to retrieve the results:

Once the search is completed we store the historical data in the Rails database so it can be retrieved or queried at a later time.

Only one seach per ticker per day is allowed to ensure we are not making duplicate requests as well as not exceeding our API quota.

* Ruby version - 3.0.1

* System dependencies

For development the only system dependency you will need is ruby, bundler, and redis. RVM is recommended to manage your Ruby version and installation. Redis can be installed and enabled with the following commands:

MacOS:
```
brew install redis
```
Ubuntu:

```
sudo apt-get install redis-server
sudo systemctl enable redis-server.service
```

If you need to debug the pipeline build you may also want Docker installed so that you can run the container build locally.

* Configuration


* Database creation
Since we are using SQLite, database creation and management is handled by the Rails migration task.

* Database initialization
In order to intialize the database, run the migration:

```
bundle exec rake db:migrate
```

* How to run the test suite
RSpec is used to implement the unit and integration tests for the project. You can run the tests with the following command:

```
bundle exec rspec
```

In order to skip the tests that make requests to the API, you can set the following environment variable:

```
export STONKS_SKIP_TEST_REQUESTS=true
```
This is helpful as we are capped at 250 requests per day for the API, so if you plan on running the full suite multiple times consider setting this variable.


* Deployment instructions

This app is deployed on Heroku, so deployment is really simple. Just run the following commands to push the latest code to the heroku app:

```
heroku login
git push heroku main
heroku run rake db:migrate
```

This will deploy the latest version of the code to Heroku and run the database migration.

# Usage
In order to create a new search, make the following request to the server:
```
curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"search": {"ticker": "AAPL" }}' \
  http://pure-anchorage-99304.herokuapp.com/searches
```


In order to retrieve the results from an exisiting search use the following request:

```
curl --header "Content-Type: application/json" \
  --request GET \
  http://pure-anchorage-99304.herokuapp.com/searches/1
```

You can also retrieve cached company and price data. In order to retrieve price data for a company use the following request:

```
curl --header "Content-Type: application/json" \                           
  --request GET \  
  http://pure-anchorage-99304.herokuapp.com/companies/1/prices
```
```

You can also filter the results using the following syntax:
```
curl --header "Content-Type: application/json" \                           
  --request GET \  
  http://pure-anchorage-99304.herokuapp.com/companies/1/prices\?start_date\=2021-05-25\&end_date\=2021-06-01
```

Sorting is also supported like so:

```
curl --header "Content-Type: application/json" \                           
  --request GET \  
  http://pure-anchorage-99304.herokuapp.com/companies/1/prices\?sort_by\=high
```

