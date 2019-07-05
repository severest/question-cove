FROM starefossen/ruby-node:2-6

RUN apt-get update && apt-get install -y mysql-client --no-install-recommends && rm -rf /var/lib/apt/lists/*

ENV RAILS_ENV=production

WORKDIR /questioncove
COPY Gemfile* ./
RUN bundle install --deployment --without development test

COPY . .

RUN bin/rails assets:precompile

EXPOSE 3000
