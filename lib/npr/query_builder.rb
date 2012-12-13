##
# NPR::QueryBuilder
#
module NPR
  class QueryBuilder
    CLASS_BUILDER_METHODS = [
      :where,
      :order,
      :limit,
      :offset
    ]
    
    attr_reader :_klass, :builder
    
    def initialize(klass)
      @_klass  = klass
      @builder = {}
    end
    
    #-----------------------
    # Build the params hash.
    def to_params
      if @_klass == NPR::Story
        conditions = parse_conditions(@builder[:conditions]) || {}
      else
        conditions = @builder[:conditions] || {}
      end
      
      params = conditions
      
      params[:sort]       = @builder[:order]
      params[:numResults] = @builder[:limit]
      params[:startNum]   = @builder[:offset]
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
    # Extra convenience:
    #
    # * You may pass an array to :id
    #
    #     query.where(id: [70, 180])
    #
    # * You may pass a date range to :date
    #
    #     last_week = Time.new(2012, 10, 21)
    #     yesterday = Time.new(2012, 10, 25)
    #     query.where(date: (last_week..yesterday))
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
    
    #-----------------------
    # Offset the number of results 
    # Useful for pagination
    #
    # Accepts an Integer.
    #
    # Example:
    #
    #   query.offset(100)
    #
    def offset(offset)
      @builder[:offset] = offset
      self
    end
    
    #-----------------------
    
    private
    
    #-----------------------
    
    def parse_conditions(conditions)
      if conditions[:id].is_a? Array
        conditions[:id] = conditions[:id].join(",")
      end
      
      if conditions[:date].is_a? Range
        conditions[:startDate] = conditions[:date].first
        conditions[:endDate]   = conditions[:date].last
        conditions.delete(:date)
      end
      
      conditions
    end
  end # QueryBuilder
end # NPR
