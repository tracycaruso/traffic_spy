require './test/test_helper'

class UserViewsEventDataTest < FeatureTest

  def test_user_views_identifier
    visit '/sources/jumpstartlab/events/socialLogin'
    within ('header'){
      assert page.has_content?("jumpstartlab")
    }
  end

  def test_user_can_use_side_nav
    visit '/sources/jumpstartlab/events/socialLogin'
    within ('aside'){
        assert page.has_content?("Event Data")
        click_link_or_button("Event Data")
    }
    assert_equal '/sources/jumpstartlab/events', current_path

    within ('aside'){
        assert page.has_content?("Dashboard")
        click_link_or_button("Dashboard")
    }
    assert_equal '/sources/jumpstartlab', current_path
  end

  def test_user_views_event_data
    visit '/sources/jumpstartlab/events/socialLogin'
    within ('.events_per_hour'){
      assert page.has_content?("Hour 21: had 1 event occurance(s).")
      assert page.has_content?("Hour 23: had 1 event occurance(s).")
    }

    within ('.total_events'){
      assert page.has_content?("2")
    }
  end

  def test_user_views_error_page
    visit '/sources/jumpstartlab/events/peanuts'
    assert page.has_content?("Events not found")
  end

end
