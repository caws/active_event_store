# frozen_string_literal: true

require "rails_helper"

describe ActiveEventStore::Schema do
  let(:schema_class) { Class.new(ActiveEventStore::Schema) }

  describe ".attribute" do
    specify "should add attributes with their default values to the class" do
      schema_class.attribute(:hello, 'world')

      expect(schema_class.attributes).to match_array([:hello])
      expect(schema_class.schema_attributes)
        .to match_array(
              [
                ActiveEventStore::SchemaAttribute.for(
                  attribute: :hello,
                  default_value: 'world'
                )
              ]
            )
    end

    specify "should raise DuplicatedAttributeError if the same attribute is defined more than once" do
      schema_class.attribute(:hello, 'world')

      expect do
        schema_class.attribute(:hello, 'world')
      end.to raise_error(ActiveEventStore::Schema::DuplicatedAttributeError)
    end
  end

  describe "#call" do
    specify "should collaborate with schema_params as expected" do
      schema_params_double = double
      schema_class.attribute(:hello, 'world')

      expect(schema_params_double)
        .to receive(:for)
              .with(
                schema_attributes: schema_class.schema_attributes,
                attributes: {}
              )

      schema_class.call(
        {},
        schema_params: schema_params_double
      )
    end
  end
end
