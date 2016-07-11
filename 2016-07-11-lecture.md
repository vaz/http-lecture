# Intro to HTTP: Hyper-Text Transfer Protocol (July 11, 2016)

## Putting the "Web" in "Web Development"

So far, you've been developing programs that interact by reading
from and writing to the terminal. HTTP describes how a web application
interacts and, as it happens, it's still just text.

## What even is a protocol?

A protocol defines how parties should interact in an exchange.

This exceptionally vague definition covers all kinds of interactions,
beyond just software. A protocol can describe rules, guidelines, recommendations, expectations; can be strict or fuzzy, explicit or
implicit...

### Examples

- This lecture follows protocol. I'm standing up and you're sitting down.
  I wouldn't care if you stood, but we'd all probably rather you (or I)
  don't run around in circles, or wander off chasing some pokemon during
  lecture. Not to mention all the usual protocol that lets us all
  tolerate each other's presence in the first place. :)

- Ordering a pizza follows a protocol, and this one is a lot more similar
  to HTTP.

  - You use an identifier (e.g. phone number) to call the place you want. 
  - If they're reachable, you make a connection. You probably exchange
    hellos. (In computer networking this is lower-level stuff than HTTP.)
  - You (the client) make a request. Along with the main content of your
    request (params of the pizza) you'll provide other info, like your
    name and address, how you want to pay, etc... negotiating some of
    the more flexible parts of the protocol.
  - The pizza place (the server) responds to your request, first with
    some information about what to expect (your pizza will arrive soon,
    or that pizza doesn't exist, we don't serve tacos here, sorry I
    don't speak Swedish ... then, you hope, with the actual pizza.

HTTP is actually simpler than this. Which is nice, because computers
are way dumber than we are.

## HTTP in a nutshell

- The [Hyper-Text Transfer
  Protocol](https://www.w3.org/Protocols/rfc2616/rfc2616.html) standard
  defines interaction between **CLIENT** (user, user-agent, browser) and
  **SERVER** (web application).

- It's still all text in, text out.

  (All the complicated details of networking are already abstracted away by
  your OS and webserver.)

- In HTTP, the client makes a request and the server responds. Repeat
  as necessary.

- A client sends an *HTTP Request* to read (or write to) a *resource* on
  the server. The server and the resource are identified by a *URI*.
  The request describes what the user wants to do to the resource,
  and 

  the desired action is given as a *Method*, metadata about the
  request are given as *Headers*
  
  and can refer to data in any format. HTTP doesn't care; it only
  describes the *way*
  
  HTML pages, data encoded in JSON/XML/etc, images, videos...
  Whether they're read from static files or generated dynamically
  resources, like HTML pages, assets submit forms, load assets,
  dynamically CRUD data using Javascript.  It interprets and renders responses
  from the server.

## Flow of an HTTP request/response cycle

Clients make requests. Servers look at a request, do something, and return
a response. That's it.

### First, who's involved? (Who are the parties?)

The parties involved are:

  * a client (often called user, user-agent, browser)
  * a server (a web application listening for HTTP requests)

#### Client (User Agent, Browser)

* The client wants something (they are making a request)
  * That "something" is a RESOURCE
* The client "finds" the server
  * They know a URL with which to reach the server
* The client describes their request to the server and sends it.
  * The request describes what the client wants to DO with the RESOURCE
    on the server.
* The client must conform to the HTTP standard being used

#### Server

* The server must be listening for requests
* The server must be reachable (by someone - the client)
* The server provides responses
* The server, and HTTP protocol, *in general*, are STATELESS
* The server must conform to the HTTP standard being used

### What are the parts of an HTTP request?

#### The address (protocol, domain, port, path)

The Address is a URI (a URL is a kind of URI).

The URI will include:

    http://www.example.com:80/some/path/to/index.html?param=1234&other=hello#anchor

  * a protocol (HTTP, HTTPS)
  * a domain (and optional port, default is 80 for unsecured HTTP)
    * e.g. www.example.com:80
  * a path: /some/path/to/index.html?param=1234
    * a path might have a query string with parameters: ?param=1234&q=hello
  * anchor hash (internal link): #some-anchor
    * often "abused" by front-end JS libraries for other purposes (routing)

#### Method

A Method is like a verb. It's what the Client wants to do with the
Resource on the Server.

e.g. GET, POST, PUT, DELETE, ...

Some correlation here with some ORM concepts (CRUD):

  * POST -> Create
  * GET -> Read
  * PUT -> Update (replace a resource)
  * PATCH -> Update (differential update)
  * DELETE -> Destroy

These correlations are not strictly enforced (a server can misbehave) but are
implied by the HTTP standard.

##### Safety and idempotence

  - Safe methods: GET, HEAD (same as get but response body omitted). Safe
    methods should not change resources on a server (read operations).

  - Idempotent methods: Methods that, when repeated more than once, have the
    same general effect on the resource as if used once. PUT and DELETE are
    idempotent.

  - POST and PATCH are neither.

Reference on HTTP Methods: https://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html

#### Headers

Both HTTP requests and responses have Headers. Headers are like key-value
pairs and describe meta-data about the message or its sender.

Headers look like this:

    Content-Type: text/html; charset=utf8
    User-Agent: My Custom User Agent
    ...

#### Body (optional)

The content being sent to the other party.

Usually a GET request will not have a body (of course the response usually
will). If a GET request has parameters (e.g. search form) they're generally
stored in the URL as a query string ?name=value&name2=value2 ...

A POST request might have the values from an HTML form submission, for
example (or JSON, or XML, or ...) in the body.

Responses often have HTML to display, but can also return images or other
binary data, stylesheets, etc.

The body is interpreted based on the standard 'Content-Type' header. For example,
if the response is an HTML document, the Content-Type header will contain "text/html".

#### HTTP Status Code

Sent by the Server describing the status of the request. The status code
is a 3-digit number, and each code comes with a short text name, which is
there to make it easier for humans to read.

Some examples:

  * 1xx (Informational)
  * 2xx = (Successful)
    * 200 OK
    * 201 Created
  * 3xx = (Redirection) - used with a `Location` header
    * 301 Moved Permanently
    * 302 Found (aka Moved Temporarily)
  * 4xx = (Client Error)
    * 400 Bad Request (invalid syntax in the request)
    * 403 Forbidden (you're not authorized to do this to that)
    * 404 Not Found
    * 405 Method Not Allowed (you can't do this to that and you should know
      better)
  * 5xx = Server Error
    * 500 Internal Server Error (request was valid but server failed to
      complete it)
    * 501 Not Implemented (you can't do this to that but it's maybe my
      fault, or maybe someday)
    * 502 Bad Gateway (e.g. routing issue at an intermediate host, proxy or
      load balancer)

Reference on HTTP Response Statuses: https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html

## The HTTP/1.1 spec

[HTTP 1.1 Spec](https://www.w3.org/Protocols/rfc2616/rfc2616.html)

## Bonus: What is Rack?

Rack is defined as an interface between HTTP and Ruby programs. Virtually
all Ruby web app frameworks are Rack-compliant.

Ruby web apps built upon Rack are able to abstract away the details of
dealing with HTTP, instead communicating over a simple Ruby interface:
a Rack application is just a Ruby callable (proc, method, etc).

You can write web apps using Rack alone, though it really doesn't help
you structure the application in a meaningful way, so we use Rack-compliant
frameworks like Sinatra and Rails.

See more: https://rack.github.io/

## What was that `http` command-line program?

It's [HTTPie](https://github.com/jkbrzt/httpie), you can install
it if you want. [HTTParty](https://github.com/jnunemaker/httparty)
is another one, written in Ruby, providing a Ruby API and a CLI tool.

An older and way more common HTTP CLI tool is [cURL](https://curl.haxx.se/).
You probably already have the `curl` command, and while it's a bit more
complicated to use, it's worth learning the basics of how to use it.

Remember that unless you really want to see the raw messages, or you just
really like doing things on the command-line for some reason (like me), it's
probably easier to get all this information in browser dev tools (in Chrome:
cmd-opt-i > Network tab > refresh the page > click a resource > look at
Headers/etc). Extensions for constructing requests to APIs are pretty good
too.
