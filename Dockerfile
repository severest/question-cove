FROM ruby:2.7.1-alpine as build-env

ARG RAILS_ROOT=/questioncove
ARG BUILD_PACKAGES="build-base git"
ARG DEV_PACKAGES="mysql-dev"
ARG RUBY_PACKAGES="tzdata nodejs"
ARG BUNDLER_VERSION="2.1.4"
ENV RAILS_ENV=production
ENV NODE_ENV=production
ENV BUNDLE_APP_CONFIG="$RAILS_ROOT/.bundle"
WORKDIR $RAILS_ROOT

RUN apk update && apk upgrade && apk add --update --no-cache $BUILD_PACKAGES $DEV_PACKAGES $RUBY_PACKAGES

COPY . .
RUN gem install bundler:$BUNDLER_VERSION && bundle install --deployment --without development test \
  && rm -rf vendor/bundle/ruby/2.7.0/cache/*.gem \
  && find vendor/bundle/ruby/2.7.0/gems/ -name "*.c" -delete \
  && find vendor/bundle/ruby/2.7.0/gems/ -name "*.o" -delete
RUN bin/rails assets:precompile
RUN rm -rf tmp/cache


FROM ruby:2.7.1-alpine
ARG RAILS_ROOT=/questioncove
ARG PACKAGES="tzdata nodejs mysql-dev"
ENV RAILS_ENV=production
ENV BUNDLE_APP_CONFIG="$RAILS_ROOT/.bundle"
WORKDIR $RAILS_ROOT

RUN apk update && apk upgrade && apk add --update --no-cache $PACKAGES

COPY --from=build-env $RAILS_ROOT $RAILS_ROOT
EXPOSE 3000
