FROM ruby:2.5 as base

LABEL Name=job_app Version=0.0.1

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /app
COPY . /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

# web_dev

EXPOSE 3000

FROM base as web_dev

CMD ["bundle", "exec", "rails", "server"]

# worker

FROM base as worker

CMD ["bundle", "exec", "sidekiq", "-C", "config/sidekiq.yml"]
