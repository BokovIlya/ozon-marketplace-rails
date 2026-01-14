#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate
# Optional: if you want to seed the database on every deploy (be careful with this in production!)
# bundle exec rake db:seed
