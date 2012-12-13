##
# FakeResponse
#
# Helpers for faking responses from the API
#
module FakeResponse
  #---------------------
  # Takes the filename to respond with,
  # and (optionally) any options to be passed to 
  # +FakeWeb.register_uri+.
  #
  # If no block is given, the registry will not be cleaned
  # by this method.
  #
  # If passed a block, it will clean the registry after
  # the block has been run.
  #
  def mock_response(filename, options={}, &block)
    respond_with(filename, options)
    
    response = yield
    FakeWeb.clean_registry
    
    response
  end

  #---------------------
  # Register the NPR root with FakeWeb, and set its 
  # response body to the contents of the requested file.
  def respond_with(filename, options)
    FakeWeb.register_uri(:get, 
      %r{^#{NPR::Configuration::API_ROOT}}, 
      { :body => load_fixture(filename),
        :content_type => "text/xml" 
      }.merge(options))
  end
  
  #---------------------
  # Read a fixure file
  def load_fixture(filename)
    file = filename == :random ? random_filename : filename
    File.read(File.join FIXTURE_ROOT, file)
  end
  
  #---------------------
  # Select a random response fixture
  def random_filename
    filename = Dir["#{FIXTURE_ROOT}/**/*story*.rb"].sample
    puts "Responding with #{filename}"
    filename
  end
end # FakeResponse
