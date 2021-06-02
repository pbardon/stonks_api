# syntax=docker/dockerfile:1
FROM ruby:3.0
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /stonks
COPY Gemfile /stonks/Gemfile
COPY Gemfile.lock /stonks/Gemfile.lock
RUN bundle install

ADD . /stonks

RUN bundle exec rspec

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["ruby", "/stonks/bin/rails", "server", "-b", "0.0.0.0"]
