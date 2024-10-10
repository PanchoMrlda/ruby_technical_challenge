To create the Docker container and enter it:
- `docker-compose run --rm ruby-app bash`

To run the script inside the Docker container:
- `BASED=SVQ bundle exec ruby main.rb input.txt`

To run the tests inside the Docker container (only test and development environments):
- `bundle exec rspec`
