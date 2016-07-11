# Really basic web application built directly on Rack
# See https://rack.github.io/

# A Rack "application" is a callable object (that is,
# an object that responds to a #call method), that can be called
# with one paramater, the "environment" of the request.
# See
# http://www.rubydoc.info/github/rack/rack/master/file/SPEC#The_Environment
#
# A Rack application is expected to return an array with 3 elements:
# [status_code, response_headers, body_iterable]
#
# where status_code is an HTTP status code, response-headers is a Hash,
# and body_iterable is something you can call "each" on to get lines of
# the body.

app = proc do |env|
  host = env['HTTP_HOST']
  request_method = env['REQUEST_METHOD']
  response_body = %{
Hi there,
this is a response body to your #{request_method} request.

Thanks for contacting #{host}
}
  [
    '200',
    { 'Content-Type' => 'text/plain' },
    response_body.lines
  ]
end

# 'run' method is provided by Rack. Rack doesn't need
# to be required because you run this with `rackup` and
# not `ruby`.
run app
