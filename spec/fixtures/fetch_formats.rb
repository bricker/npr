##
# A script to automatically fetch fixtures from
# the NPR API. Also removes API Key in responses.
#
# ARGS:
# 1. -k / --key API Key
# 2. -i / --id Story ID
# 3. -f / --filename Filename (no dir or ext, eg. 03_story_multiple)
#
# Run from command line from the +fixtures+ folder. Example:
#
#   export KEY="YOUR_API_KEY"
#   ruby fetch_formats.rb --key `echo $KEY` --id 166946294 --filename 04_story_multiple_bylines
#
require "optparse"
require "net/http"
require "uri"

# Parse command line arguments
options = {}

OptionParser.new do |opts|
  opts.banner = "Usage: ruby fetch_formats.rb [ARGS]"
  
  opts.on('-k', '--key KEY', 'Your NPR API Key') do |key|
    options[:key] = key
  end

  opts.on('-i', '--id ID', 'The ID of the story to fetch') do |id|
    options[:id] = id
  end

  opts.on('-f', '--filename [FILENAME]', 'The filename to write to (no extension)') do |filename|
    options[:filename] = filename || "story_#{options[:id]}"
  end
end.parse!


# Map of outputs => extensions
ext_map = {
  "nprml"    => "xml",
  "json"     => "json",
  "js"       => "js",
  "html"     => "html",
  "rss"      => "rss",
  "mediarss" => "rss",
  "podcast"  => "rss",
  "atom"     => "atom"
}

# The fun stuff
ext_map.keys.each do |output|
  puts "Fetching #{output}..."
  
  uri = URI.parse("http://api.npr.org/query?apiKey=#{options[:key]}&id=#{options[:id]}&output=#{output}")
  response = Net::HTTP.get_response(uri).body
  
  # Remove API Key from responses  
  response.gsub!(/#{options[:key]}/, "API_KEY")
  
  file = "#{output}/#{options[:filename]}.#{ext_map[output]}"
  File.open(file, "w") { |f| f.puts response }
end
