# Use an official Ruby runtime as a parent image
FROM ruby:3.0

# Set the working directory inside the container
WORKDIR /ruby-app

# Copy the current directory contents into the container at /ruby-app
COPY . /ruby-app

# Install Bundler
RUN gem install bundler

# Install any needed gems specified in Gemfile
RUN bundle install
