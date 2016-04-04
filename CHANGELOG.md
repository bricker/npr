### 3.0.0
#### Changes
* Transcripts now has many links instead of one.
* `has_many` association can take either a collection or a single object.

### 2.0.2
#### Changes
* More strict faraday_middleware dependency.


### 2.0.1 (2014-02-27)
#### Changes
* Be more strict about Faraday dependecies.


### Version 2.0.0 (2013-11-08)
##### Additions
* Added `NPR::Entity::Stream`.
* Added `empty?` method to `NPR::Entity::Formats`. Since `audio.formats` isn't
  actually an Enumerable, this method is defined to make it easy to check if
  any formats have been provided for this audio. This is a good way to check
  if the audio is actually available yet.

##### Changes
* `Audio#stream` now returns an `NPR::Entity::Stream` object. This will break
  your code if you were doing something like `if audio.stream == true`.
  To fix it, you can just use: `if audio.stream.active?`.
* Changed the `offset` method on `QueryBuilder` to set `startNum` to
  `offset + 1`. Previously, if you said `.offset(1)`, you would actually still
  get the first result, because it was passing its value directly to the
  `startNum` parameter, which is confusing. Now you can say `.offset(1)` and
  the results will actually be offset by 1 object. This behavior is to mimic
  ActiveRecord a little more closely.

##### Deprecations
* None


### Version 1.2.0 (2013-08-05)
##### Additions
* Added support for the `parent` node.
* Added the `#link_for` method for any node which has (multiple) nested links.
* Added `#download?`, `#stream?`, and `#embed?` methods to Permission, to return
  booleans of whether that permission is allowed.
* Added support for the `externalAsset` node, as `Story#external_assets (array)`

##### Changes
* None

##### Deprecations
* None



### Version 1.1.0 (2013-06-05)

##### Additions
* Allow passing `:url` option to Client, and `:path` option to `Client#query`
* Allow passing `:apiKey` and `:output` to `Client#query`
* Add an Image#crop method, to find a specific crop by its type.

##### Changes
* Handle an HTTP Error from the API better. If the API response is not a
  success (as defined by `Faraday::Response#success?`), then an
  `NPR::APIError` will be raised. An error was being raised before, but
  it was due to a nil error (when response.body was nil), which could be confusing.

##### Deprecations
  * None



### Version 1.0.0
* Stable release



### Version 0.1.2 (2012-12-30)
* Critical bug fix having to do with JSON parsing.



### Version 0.1.1 (2012-12-16)
* First stable release.
