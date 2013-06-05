### Version 1.1.0 (2013-06-05)
* Allow passing `:url` option to Client, and `:path` option to `Client#query`
* Allow passing `:apiKey` and `:output` to `Client#query`
* Handle an HTTP Error from the API better. If the API response is not a
  success (as defined by `Faraday::Response#success?`), then an 
  `NPR::APIError` will be raised. An error was being raised before, but
  it was due to a nil error (when response.body was nil), which could be confusing.
* Add an Image#crop method, to find a specific crop by its type.


### Version 1.0.0
* Stable release


### Version 0.1.2 (2012-12-30)
* Critical bug fix having to do with JSON parsing.


### Version 0.1.1 (2012-12-16)
* First stable release.
