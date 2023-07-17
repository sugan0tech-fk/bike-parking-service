FROM ruby:2.7.5

WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    nodejs

RUN gem install rails -v '7.0.5'

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

EXPOSE 3000

CMD ["rails", "server"]
