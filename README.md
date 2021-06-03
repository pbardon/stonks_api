# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version - 3.0.1

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions


curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"search": {"ticker": "BRK.B" }}' \
  http://localhost:3000/searches



curl --header "Content-Type: application/json" \
  --request GET \
  http://localhost:3000/searches/1


