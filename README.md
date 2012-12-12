# NPR API Ruby Client

**NOTE** This gem is a WIP

A simple Ruby client for the NPR API.


## Support

This gem is tested with these versions (but may 
work with others):

* Ruby 1.8.7, 1.9.2, 1.9.3
* NPR API version 0.94


## Dependencies

* activesupport
* faraday (HTTP requests)
* faraday_middleware (response processing)
    * multi_xml (XML parsing)


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

    NPR.configure do |config|
      config.apiKey         = "YOUR_API_KEY"
      config.sort           = "date descending"
      config.output         = "NPRML"
      config.requiredAssets = "text"
    end

For a Rails application, a good place to put the configuration 
would be in an initializer, such as `config/initializers/npr_config.rb`.

### DSL

The DSL is modeled after Rails' `ActiveRecord::Relation`, so for the 
most part, if you understand that, then using the NPR gem will come
naturally to you!

To find a story by ID:

    NPR::Story.find(1999) #=> NPR::Story

You can also query directly on an NPR::Client object:

    client = NPR::Client.new(apiKey: NPR.config.apiKey)
    client.query(id: 63985) #=> NPR::Story

The params that get passed into the `#query` method map directly to
the parameters that NPR's API accepts. See the 
[NPR API Input Reference](http://www.npr.org/api/inputReference.php) 
for all of the options.


## TODO

* Specs
* Documentation
* Support all of NPR's output formats:
    * JSON
    * RSS
    * mediaRSS
    * ATOM
    * HTML?
    * Javascript?


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
