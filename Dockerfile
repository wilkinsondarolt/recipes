FROM ruby:2.6.5

LABEL maintainer="Wilkinson Da Rolt de Souza"

# Install Node.js and Yarn
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Install dependencies
RUN apt-get update
RUN apt-get install -qq -y --no-install-recommends apt-utils build-essential nodejs yarn

# Create the workdir
RUN mkdir /app

# Set our path as the main directory
WORKDIR /app

# Optimizing Dockerfile caching for Bundler
COPY Gemfile Gemfile.lock package.json yarn.lock ./

# Install Yarn and Bundle
RUN yarn install
RUN bundle install

# Copy our code into the container
COPY . .

# Run the application
CMD bundle exec rails s -p ${PORT} -b '0.0.0.0'
