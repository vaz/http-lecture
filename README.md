# Intro to HTTP

## What is HTTP

HTTP is Hyper-Text Transfer Protocol.

### OK, What is Hyper-Text?

That concept where documents are able to link to other documents.

#### So what then is HTML (Hyper-Text Markup Language)

It's a *Markup Language* for describing hyper-text documents, i.e. documents
that contain hyperlinks to other documents/resources.

It is a very different thing from HTTP, though they are often used together.

## So what's a protocol?

A protocol is a set of rules, suggestions (strong suggestions, optional
features, etc) describing how parties communicate an interaction.

### What are examples of protocols:

* Getting a coffee at Starbucks follows a protocol
  * You will not get your coffee is you breach protocol (e.g. get naked)
* Being in this lecture follows a protocol
  * You behave within parameters (and so do I)
* KKJS...

### What's KKJS?

Knock-knock Joke Protocol.

1. *P1 gets the attention of P2*
2. P1: Knock knock
3  P2: Who's there
4. P1: #{someone}
5. P2: #{someone} who?
6. P1: *be funny* (aka #{punchline}
7. *connection closed*

If you don't follow the protocol, the joke delivery will fail.

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

    http://www.example.com:80/some/path/to/index.html?param=1234

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
  * PUT -> Update
  * DELETE -> Destroy

These correlations are not strictly enforced but are implied by the HTTP
standard.

Reference on HTTP Methods: [https://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html]

#### Headers

Both HTTP requests and responses have Headers. Headers are like key-value
pairs. Both keys and values are just strings because everything in HTTP is
a string (though they can be interpreted as representing other types).

Headers look like this:

    Content-Type: text/html; charset=utf8
    User-Agent: My Custom User Agent

#### Body (optional)

The content being sent to the other party.

Usually a GET Request body will not have a body. A Post Request might have
the values from an HTML form submission, for example.

Responses often have HTML to display, but can also return images or other
binary data, stylesheets, etc.

The body is interpreted based on the standard 'Content-Type' header.

#### HTTP Status Code

Sent by the Server describing the status of the request.

Some examples:

  * 1xx (Informational)
  * 2xx = (Successful)
    * 200 OK
    * 201 Created
  * 3xx = (Redirection)
    * 301 Moved Permanently
    * 302 Found (aka Moved Temporarily)
  * 4xx = (Client Error)
    * 400 Bad Request (invalid syntax in the request)
    * 404 Not Found
  * 5xx = Server Error
    * 500 Server Error (request was valid but server failed to complete it)

Reference on HTTP Response Statuses: [https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html]

## The HTTP/1.1 spec

[https://www.w3.org/Protocols/rfc2616/rfc2616.html]

