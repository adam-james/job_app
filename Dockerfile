FROM ruby:2.5.3 as base

LABEL Name=job_app Version=0.0.1

RUN apt-get update -qq && apt-get install -y postgresql-client apt-transport-https

# Install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y nodejs yarn

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

# worker_dev

FROM base as worker_dev

CMD ["bundle", "exec", "sidekiq", "-C", "config/sidekiq.yml"]

# production

FROM base as prod

# TODO this needs to be Kubernetes Secret or Config
RUN /bin/bash -c "source ./bin/env.sh"

ENV RAILS_ENV production

# worker_prod

FROM prod as worker_prod

CMD ["bundle", "exec", "sidekiq", "-C", "config/sidekiq.yml"]

# web_prod

FROM prod as web_prod

EXPOSE 3000

RUN rails assets:precompile

CMD ["bundle", "exec", "rails", "server"]
