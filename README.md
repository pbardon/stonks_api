# Stonks API

This project is used to search and populate historical daily price data for US stocks. It consumes the following API in order to retrieve the results:


Once the search is completed we store the historical data in the Rails database so it can be retrieved or queried at a later time.

Only one seach per ticker per day is allowed to ensure we are not making duplicate requests as well as not exceeding our API quota.

* Ruby version - 3.0.1

* System dependencies

For development the only system dependency you will need is ruby and bundler, the rest of the dependencies are loaded via Ruby. RVM is recommended to manage your Ruby version and installation.

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

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions


# Usage
In order to create a new search, make the following request to the server:
```
curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"search": {"ticker": "BRK.B" }}' \
  http://localhost:3000/searches
```


In order to retrieve the results from an exisitng search use the following request:

```
curl --header "Content-Type: application/json" \
  --request GET \
  http://localhost:3000/searches/1
```

You can also retrieve cached company and price data. In order to retrieve price data for a company use the following request:

```
```

You can also filter the results using the following syntax:
```
```

Sorting is also supported like so:

```
```

