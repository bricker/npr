##
# Errors
#
module NPR
  class ClientError < StandardError
  end
  
  #-------------------
  
  class ServerError < StandardError
  end
  
  #-------------------
  
  class NotConfiguredError < ClientError
  end  
end # NPR
