module ActiveEventStore
  class SchemaParams
    class << self
      def for(schema_attributes:, attributes:)
        Struct.new(*schema_attributes.map(&:attribute)).new(
          *schema_attributes.map.with_object({}) do |schema_attribute, hash|
            hash[schema_attribute.attribute] = attributes.fetch(
              schema_attribute.attribute,
              schema_attribute.default_value
            )
          end.values
        ).to_h
      end
    end
  end
end