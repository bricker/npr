##
# NPR::Concern::Relation
#
module NPR
  module Concern
    module Relation
      def self.included(base)
        base.extend ClassMethods
      end

      #-----------------

      module ClassMethods
        #-----------------
        # Define a relationship
        # Similar to ActiveRecord's +has_many+
        #
        # Arguments:
        #
        # * name (String) - the name of the relation
        # * options (Hash)
        #     * class_name (Class) - the class for the related objects
        #     * key (String) - the JSON key that holds this relation
        #
        # Example:
        #
        #   has_many "links", key: "link", class_name: NPR::Entity::Link
        #
        def has_many(name, options)
          relation = build_relation(name, options)

          # Define getter and setter for this attribute
          # Forces the relation into an empty array when
          # it's first accessed.
          attr_writer name
          define_method name do
            instance_variable_get("@#{name}") || instance_variable_set("@#{name}", [])
          end

          _has_many_relations.push relation
        end

        #-----------------

        def has_one(name, options)
          relation = build_relation(name, options)
          attr_accessor name
          _has_one_relations.push relation
        end

        #-----------------

        def _has_many_relations
          @_has_many_relations ||= []
        end

        def _has_one_relations
          @_has_one_relations ||= []
        end

        #-----------------

        private
        attr_writer :_has_many_relations, :_has_one_relations

        def build_relation(name, options)
          relation = {
            :name       => name,
            :class_name => options[:class_name],
            :key        => options[:key] || name
          }
        end
      end


      #-----------------

      private

      #-----------------

      def create_relations(json)
        self.class._has_many_relations.each do |relation|
          collection = []

          if node = json[relation[:key]]
            Array.wrap(node).each do |obj|
              collection.push relation[:class_name].new(obj)
            end
          end

          send "#{relation[:name]}=", collection
        end

        self.class._has_one_relations.each do |relation|
          if node = json[relation[:key]]
            send "#{relation[:name]}=", relation[:class_name].new(node)
          end
        end
      end
    end # Relation
  end # Concern
end # NPR
