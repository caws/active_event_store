module ActiveEventStore
  class SchemaAttribute
    attr_accessor :attribute, :default_value, :required

    def initialize(attribute:, default_value:, required: false)
      @attribute = attribute
      @default_value = default_value
      @required = required
    end

    def ==(other)
      attribute == other.attribute &&
        default_value == other.default_value &&
        required == other.required
    end

    class << self
      def for(attribute:, default_value: nil, required: false)
        self.new(
          attribute: attribute,
          default_value: default_value,
          required: required
        )
      end
    end
  end
end