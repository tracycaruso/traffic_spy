require './test/test_helper'

class UserViewsUrlDataTest < FeatureTest

  def test_user_views_identifier
    visit '/sources/jumpstartlab/urls/blog'
    within ('header'){
      assert page.has_content?("jumpstartlab")
      assert page.has_content?("http://jumpstartlab.com/blog")
    }
  end

  def test_user_can_use_side_nav
    visit '/sources/jumpstartlab/urls/blog'
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

  def test_user_views_url_data
    visit '/sources/jumpstartlab/urls/blog'

    within ('.longest_response'){
        assert page.has_content?("20")
    }

    within ('.shortest_response'){
        assert page.has_content?("10")
    }

    within ('.average_response'){
        assert page.has_content?("15")
    }

    within ('.request_types'){
        assert page.has_content?("GET, POST")
    }

    within ('.popular_referrers'){
        assert page.has_content?("http://jumpstartlab.com")
    }

    within ('.popular_browsers'){
        assert page.has_content?("Chrome")
    }
  end

  def test_user_views_error_page
    visit '/sources/jumpstartlab/urls/peanuts'
    assert page.has_content?("Message that the url has not been requested")
  end
end
