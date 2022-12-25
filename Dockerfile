FROM ruby:2.7.4-alpine

LABEL maintainer="davidmartingarcia0@gmail.com"

WORKDIR /usr/src/app

RUN apk update && apk add --no-cache build-base git

RUN gem install bundler:2.2.25

COPY Gemfile* ./
COPY tweakphoeus.gemspec ./
COPY lib/tweakphoeus/version.rb ./lib/tweakphoeus/

RUN bundle install

COPY ./ ./

CMD ["bundle", "exec",  "irb"]