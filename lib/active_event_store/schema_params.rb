module ActiveEventStore
  class SchemaParams
    RequiredAttributeNotPresentError = Class.new(StandardError)

    class << self
      def for(schema_attributes:, attributes:)
        ensure_required_params_are_present!(
          schema_attributes.select do |schema_attribute|
            schema_attribute.required
          end.map(&:attribute),
          attributes.keys
        )

        Struct.new(*schema_attributes.map(&:attribute)).new(
          *schema_attributes.map.with_object({}) do |schema_attribute, hash|
            hash[schema_attribute.attribute] = attributes.fetch(
              schema_attribute.attribute,
              schema_attribute.default_value
            )
          end.values
        ).to_h
      end

      private

      def ensure_required_params_are_present!(required_attributes, attributes_present)
        required_attributes.each do |required_attribute|
          unless attributes_present.include?(required_attribute)
            raise RequiredAttributeNotPresentError, "#{required_attribute} is required but not present"
          end
        end
      end
    end
  end
end