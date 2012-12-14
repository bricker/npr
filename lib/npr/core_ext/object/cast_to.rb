require 'time'

##
# Define a method that knows how to convert 
# an object to whichever class you pass it into.
#
class Object
  CASTERS = {
    Fixnum => lambda { |a| a.to_i },
    Time   => lambda { |a| Time.parse(a) }
  }
  
  def cast_to(klass)
    CASTERS[klass].call(self)
  end
end
