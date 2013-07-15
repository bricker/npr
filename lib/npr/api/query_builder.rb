##
# NPR::API::QueryBuilder
#
module NPR
  module API
    class QueryBuilder
      CLASS_BUILDER_METHODS = [
        :where,
        :order,
        :limit,
        :offset,
        :set
      ]

      attr_reader :_klass, :builder

      #-----------------------

      def initialize(klass)
        @_klass  = klass
        @builder = {}
      end

      #-----------------------
      # Build the params hash.
      # This is automatically called by #to_a, so it probably
      # doesn't need to be used manually.
      def to_params
        if @_klass == NPR::Entity::Story && @builder[:conditions]
          conditions = parse_conditions(@builder[:conditions])
        else
          conditions = @builder[:conditions]
        end

        params = conditions || {}
        params[:sort]       = @builder[:order]  if @builder[:order]
        params[:numResults] = @builder[:limit]  if @builder[:limit]
        params[:startNum]   = @builder[:offset] if @builder[:offset]
        params.merge!(@builder[:extra])         if @builder[:extra]

        params
      end

      #-----------------------
      # Fire the query and return an Array of stories (or empty [])
      #
      # Returns an Array. If the query returned any stories, then
      # it will be an array of those stories. If no stories were
      # returned, then it will be an empty array.
      #
      # There is no way to access the List or Messages returned
      # from the response. This method is meant to be a way to
      # get to the Stories as quickly and easily as possible.
      # If you want access to the full Response object, use #query.
      #
      # Example:
      #
      #   query = NPR::API::QueryBuilder.new(NPR::Story)
      #   query.where(:id => [100, 150]).to_a
      #   #=> [NPR::Story, NPR::Story]
      #
      #   # Assuming there is no story with an ID of 1
      #   query.where(:id => 1).to_a
      #   #=> []
      #
      # Note that for this method, +NPR.config.apiKey+ must be set.
      #
      def to_a
        response = self.query
        stories  = []

        if response.list
          stories = Array.wrap(response.list.stories)
        end

        stories
      end

      #-----------------------
      # Fire the query and return the full Response object
      #
      # Example:
      #
      #   query = NPR::API::QueryBuilder.new(NPR::Story)
      #   query.where(:id => [100, 150]).query
      #   #=> NPR::API::Response
      #
      # See NPR::API::Response for what methods are available
      # to you.
      #
      # Note that for this method, +NPR.config.apiKey+ must be set.
      def query
        client.query(self.to_params)
      end

      #-----------------------
      # Add in arbitrary parameters.
      #
      # These take precedence over anything set via
      # any of the other builder methods.
      #
      # Accepts a hash of key/values that the API
      # can receive and handle.
      #
      # Example:
      #
      #   query.set(apiKey: "YOUR_API_KEY")
      #
      def set(params)
        @builder[:extra] = (@builder[:extra] || {}).merge(params)
        self
      end

      #-----------------------
      # Merge in the passed-in conditions to what
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

      def client
        @client ||= NPR::API::Client.new(:apiKey => NPR.config.apiKey)
      end

      #-----------------------

      def parse_conditions(conditions)
        parse_conditions!(conditions.dup)
      end

      #-----------------------

      def parse_conditions!(conditions)

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
  end # API
end # NPR
