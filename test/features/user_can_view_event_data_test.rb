require './test/test_helper'

class UserViewsEventDataTest < FeatureTest

  def test_user_views_identifier
    visit '/sources/jumpstartlab/events'
    within ('header'){
      assert page.has_content?("jumpstartlab")
    }
  end

  def test_user_can_use_side_nav
    visit '/sources/jumpstartlab/events'
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
    visit '/sources/jumpstartlab/events'
    within ('.events'){
        assert page.has_content?("socialLogin")
        click_link_or_button("socialLogin")
    }
    assert_equal '/sources/jumpstartlab/events/socialLogin', current_path

    visit '/sources/jumpstartlab/events'
    within ('.events'){
        assert page.has_content?("submit")
        click_link_or_button("submit")
    }
    assert_equal '/sources/jumpstartlab/events/submit', current_path

    visit '/sources/jumpstartlab/events'
    within ('.events'){
        assert page.has_content?("delete")
        click_link_or_button("delete")
    }
    assert_equal '/sources/jumpstartlab/events/delete', current_path
  end

  def test_user_views_error_page
    visit '/sources/peanuts/events'
    assert page.has_content?("Events not found")
  end

end
