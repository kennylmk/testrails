FROM ruby:2.7.3

ENV BUNDLER_VERSION=2.0.2

RUN gem install bundler -v 2.2.21

# RUN mkdir /scores
# COPY Gemfile /API_scores
# COPY Gemfile.lock /scores
# RUN bundle check || bundle install

WORKDIR /app

COPY package.json yarn.lock ./

# RUN yarn install --check-files

COPY Gemfile \
     Gemfile.lock \
     /app/

RUN gem install bundler && bundle install
RUN gem install sqlite3-ruby
# RUN sudo apt install nodejs
# RUN sudo apt install npm
# RUN npm install --global yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg -o /root/yarn-pubkey.gpg && apt-key add /root/yarn-pubkey.gpg
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y --no-install-recommends nodejs yarn
RUN yarn install
RUN gem install rails

COPY . /app

EXPOSE 3001
CMD ["rails","s","-p","3001"]