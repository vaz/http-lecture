require 'sinatra'
require 'json'

get '/' do
  content_type :json # sets Content-Type header
  request.env.to_json
end
