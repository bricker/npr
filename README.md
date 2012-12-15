# NPR API Ruby Client

[![Build Status](https://travis-ci.org/bricker88/npr.png)](https://travis-ci.org/bricker88/npr)
 
**NOTE** This gem is a WIP

A simple Ruby client for the 
[NPR API](http://www.npr.org/api/index).


## Support

This gem is tested with these versions (but may 
work with others):

* Ruby 1.8.7, 1.9.2, 1.9.3, ruby-head
* NPR API version 0.94


## Dependencies

* `faraday >= 0.8.0` (HTTP requests)
* `faraday_middleware >= 0.9.0` (response processing)

**NOTE** If you are running **Ruby < 1.9**, you will have to install 
the [json gem](http://rubygems.org/gems/json):

In your Gemfile:

    gem 'json', '~> 1.7.5'
    
From the command line:

    $ gem install json

Ruby 1.9+ comes with JSON support built-in!


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
  config.output         = "NPRML"
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
NPR::Entity::Story.find(1999) #=> NPR::Story
```

`NPR::Story#find` will either return a Story object if it was found,
or an array of Messages from the NPR API.

You can also query directly on an `NPR::API::Client` object, if you're
feeling adventurous:

```ruby
client = NPR::API::Client.new(apiKey: NPR.config.apiKey)
client.query(sort: "edit assigned", numResults: "12")
```

The params that get passed into the `#query` method map directly to
the parameters that NPR's API accepts. See the 
[NPR API Input Reference](http://www.npr.org/api/inputReference.php) 
for all of the options.


## TODO

* More Documentation
* Abstract attributes so they're not tied directly to the API response.
Also to make them more Ruby-conventional (i.e. snake_case)
    * Example: "apiKey" => :api_key
* Support more attributes/relations natively
* Support a way to return raw formats of:
    * HTML / Javascript (for views)
    * JSON
    * ATOM
    * RSS


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
