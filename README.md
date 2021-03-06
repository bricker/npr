# NPR API Ruby Client

[![Build Status](https://travis-ci.org/bricker/npr.png)](https://travis-ci.org/bricker/npr)
 
A simple Ruby client for the 
[NPR API](http://www.npr.org/api/index). Alternative documentation for the NPR
API can be found at <http://dev.npr.org>.


## Support

This gem is tested with these versions (but may 
work with others):

* Ruby 1.9.2, 1.9.3, 2.0.0
* NPR API version 0.94


## Dependencies

* `faraday >= 0.8.0` (HTTP requests)
* `faraday_middleware >= 0.9.0` (response processing)


## Installation

Add this line to your application's Gemfile:

    gem 'npr'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install npr


## Usage

### API Key

NPR requires that you have an API key in order to use 
their API. More information about this (including how 
to register) can be found at
[NPR's API Documentation](http://www.npr.org/api/index).

### Configuration

API requests can be configured globally. This is recommended 
for setting the API Key, but you can also set other parameters
which will be passed in with every request (unless overridden):

```ruby
NPR.configure do |config|
  config.apiKey         = "YOUR_API_KEY"
  config.sort           = "date descending"
  config.requiredAssets = "text"
end
```

For a Rails application, a good place to put the configuration 
would be in an initializer, such as `config/initializers/npr_config.rb`.

### DSL

The DSL is modeled after Rails' `ActiveRecord::Relation`, so for the 
most part, if you understand that, then using the NPR gem will come
naturally to you!

To find a story by ID:

```ruby
NPR::Story.find(1999) #=> NPR::Story
```

`NPR::Story#find` will either return a Story object if it was found,
or an array of Messages from the NPR API.

Building a query:

```
NPR::Story.where(date: [2.days.ago..Time.now]).order("date ascending").limit(10).offset(50)
```

That's a contrived example but it shows all the methods available.

You can also query directly on an `NPR::API::Client` object, if you're
feeling adventurous:

```ruby
client = NPR::API::Client.new(apiKey: NPR.config.apiKey)
client.query(sort: "editor assigned", numResults: "12")
```

The params that get passed into the `#query` method map directly to
the parameters that NPR's API accepts. See the 
[NPR API Input Reference](http://www.npr.org/api/inputReference.php) 
for all of the options.


## TODO

* More Documentation
* Search functionality
* Add "select" method to QueryBuilder for the "fields" input
* Abstract attributes so they're not tied directly to the API response.
* Make all attributes snake_case
* Support for "correction" node
* Support for "container" node
* Support for "thumbnail" node
* Support a way to return the raw NPRML if requested.


## Contributing

Please send PR's for any new features or bug fixes!

Run tests with `bundle exec rake test`.
