##
# Errors
#
module NPR
  class ClientError < StandardError
  end

  class ServerError < StandardError
  end


  class APIError < ServerError
  end

  class NotConfiguredError < ClientError
  end
end # NPR
