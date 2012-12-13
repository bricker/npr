##
# NPR::QueryBuilder
#
module NPR
  class QueryBuilder
    CLASS_BUILDER_METHODS = [
      :where,
      :order,
      :limit
    ]
    
    attr_reader :klass, :builder
        
    def initialize(klass)
      @klass   = klass
      @builder = {}
    end
    
    #-----------------------
    # Merge in the passed-in condition to what
    # already exists.
    #
    # Accepts a Hash.
    #
    # Example:
    #
    #   query.where(id: 999, requiredAssets: "text")
    #
    def where(conditions)
      @builder[:conditions] = (@builder[:conditions] || {}).merge(conditions)
      self
    end

    #-----------------------
    # Set the order.
    #
    # Accepts a String.
    #
    # Example:
    #
    #   query.order("date descending")
    #
    def order(order)
      @builder[:order] = order
      self
    end

    #-----------------------
    # Set the limit.
    #
    # Accepts an Integer.
    #
    # Example:
    #
    #   query.limit(10)
    #
    # Note that NPR limits the maximum results to 20,
    # and will return only 20 results if more than the
    # maximum is requested.
    def limit(limit)
      @builder[:limit] = limit
      self
    end
  end
end
