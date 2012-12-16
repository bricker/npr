## Fixture Index

* list - 3002 - All Topics
* 01 - 167019577 - Story with 1 Audio, 1 Image, 1 Byline
* 02 - 166884441 - Multiple Images
* 03 - 167016221 - No Results (404-ish)
* 04 - 00 - Invalid ID
* 05 - Missing API Key
* 06 - 167055503,166956822 - More than one ID returned (on purpose)

(awesome story: 166480907)

## Adding more fixtures

`fetch_fixtures.rb` provides an easy way to pull a story 
from the NPR API in all of the possible formats. This 
allows us to more easily test edge cases. To use, run 
from this directory (`spec/fixtures`):

    ruby fetch_formats.rb --key "YOUR_API_KEY" --id 166946294 --filename 04_story_multiple_bylines

The arguments are:

```
--key      : Your API Key.
--id       : The ID of the story that you want to pull
--filename : The filename that the responses will be 
               written to (in their respective format).
               (No extension)
```
