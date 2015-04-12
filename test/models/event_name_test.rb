require './test/test_helper'
require './test/create_sources_and_payloads'

class EventNameTest < Minitest::Test
  include CreateSourcesAndPayloads

  def test_event_names_can_be_added_to_table
    TrafficSpy::EventName.create(name: "submit")

    event = TrafficSpy::EventName.last
    assert_equal "submit", event.name
  end




end
