# frozen_string_literal: true

require "rails_helper"

describe ActiveEventStore::SchemaParams do
  describe ".for" do
    let(:schema_attributes) {
      [
        ActiveEventStore::SchemaAttribute.for(
          attribute: :some_attribute_name,
          default_value: 'some_default_value'
        ),
        ActiveEventStore::SchemaAttribute.for(
          attribute: :some_other_attribute_name
        )
      ]
    }

    specify "should return a hash based on attributes and their default values" do
      schema_params = ActiveEventStore::SchemaParams.for(
        schema_attributes: schema_attributes,
        attributes: {
          some_attribute_name: 'here'
        }
      )

      expect(schema_params).to eq(
                                 {
                                   some_attribute_name: 'here',
                                   some_other_attribute_name: nil
                                 }
                               )
    end
  end
end
