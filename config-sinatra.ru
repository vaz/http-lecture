# config-sinatra.ru
#
# really basic rackup file to run a single-file Sinatra app
# run like:
#
#     bundle exec rackup config-sinatra.ru
require_relative 'app.rb'

# Sinatra::Application refers to your app, responds to #call,
# and returns the kind of response Rack wants.
run Sinatra::Application
