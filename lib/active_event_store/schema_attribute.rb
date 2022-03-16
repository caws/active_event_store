module ActiveEventStore
  class SchemaAttribute
    attr_accessor :attribute, :default_value

    def initialize(attribute:, default_value:)
      @attribute = attribute
      @default_value = default_value
    end

    def ==(other)
      attribute == other.attribute && default_value == other.default_value
    end

    class << self
      def for(attribute:, default_value: nil)
        self.new(
          attribute: attribute,
          default_value: default_value
        )
      end
    end
  end
end