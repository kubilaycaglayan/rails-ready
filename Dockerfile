# Use the official Ruby image with version 3.3.5
FROM ruby:3.3.5

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
  nodejs \
  postgresql-client \
  libssl-dev \
  libreadline-dev \
  zlib1g-dev \
  build-essential \
  curl

# Install rbenv
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv && \
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc && \
  echo 'eval "$(rbenv init -)"' >> ~/.bashrc && \
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build && \
  echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc

# Install the specified Ruby version using rbenv
ENV PATH="/root/.rbenv/bin:/root/.rbenv/shims:$PATH"
RUN rbenv install 3.3.5 && rbenv global 3.3.5

# Set the working directory
WORKDIR /app

# Copy the Gemfile and Gemfile.lock
COPY Gemfile /app/Gemfile
# COPY Gemfile.lock /app/Gemfile.lock

# Install Gems dependencies
RUN gem install bundler
RUN bundle install --jobs 12

# Copy the application code
COPY . /app

# Precompile assets (optional, if using Rails with assets)
# RUN bundle exec rake assets:precompile

# Expose the port the app runs on
EXPOSE 3000

# Command to run the server
CMD ["rails", "server", "-b", "0.0.0.0"]
