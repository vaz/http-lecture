require 'sinatra'

get '/' do
  "#{request.to_json}"
end
