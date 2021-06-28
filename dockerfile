FROM ruby:2.7.3

WORKDIR /app

COPY Gemfile \
     Gemfile.lock \
     ./
RUN bundle install

COPY . .

EXPOSE 3000
CMD ["rails","s","-p","3000","-b","0.0.0.0"]