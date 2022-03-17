# frozen_string_literal: true

require "rails_helper"

describe ActiveEventStore::SchemaAttribute do
  describe ".for" do
    specify do
      schema_attribute = ActiveEventStore::SchemaAttribute.for(
        attribute: :some_attribute_name,
        default_value: 'some_default_value',
        required: false
      )

      expect(schema_attribute.attribute).to eq(:some_attribute_name)
      expect(schema_attribute.default_value).to eq('some_default_value')
      expect(schema_attribute.required).to eq(false)
    end
  end

  describe "#==" do
    let(:schema_attribute) {
      ActiveEventStore::SchemaAttribute.for(
        attribute: :some_attribute_name,
        default_value: 'some_default_value',
        required: false
      )
    }

    specify "should be equal" do
      new_schema_attribute = ActiveEventStore::SchemaAttribute.for(
        attribute: :some_attribute_name,
        default_value: 'some_default_value',
        required: false
      )

      expect(schema_attribute).to eq(new_schema_attribute)
    end
  end
end
