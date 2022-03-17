# frozen_string_literal: true

module ActiveEventStore
  class TestEvent < ActiveEventStore::Event
    self.identifier = "test_event"

    attributes :user_id, :action_type

    sync_attributes :user
  end

  class AnotherTestEvent < TestEvent
  end

  class TestEventSchema < ActiveEventStore::Schema
    attribute :user_id, 'some_default_value_for_user_id'
    attribute :action_type, 'some_default_value_for_action_type'
    attribute :some_boolean, true
  end

  class TestEventWithSchema  < ActiveEventStore::Event
    self.identifier = "test_event_with_schema"

    with_schema TestEventSchema

    sync_attributes :user
  end
end
