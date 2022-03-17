module ActiveEventStore
  class Schema
    DuplicatedAttributeError = Class.new(StandardError)

    class << self
      attr_reader :schema_attributes

      def attribute(attribute, default_value, required: false, schema_attribute: SchemaAttribute)
        @schema_attributes ||= []

        new_attribute = schema_attribute.for(
          attribute: attribute,
          default_value: default_value,
          required: required
        )

        if @schema_attributes.include?(new_attribute)
          raise DuplicatedAttributeError, "Duplicated schema attribute: #{attribute}"
        end

        @schema_attributes << new_attribute
      end

      def attributes
        schema_attributes.map(&:attribute)
      end

      def call(attributes, schema_params: SchemaParams)
        schema_params.for(
          schema_attributes: schema_attributes,
          attributes: attributes
        )
      end
    end
  end
end