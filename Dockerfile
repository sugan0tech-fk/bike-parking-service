FROM ruby:latest

WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    nodejs

RUN gem install rails

COPY . .

RUN bundle install

RUN rails db:migrate RAILS_ENV=development

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
