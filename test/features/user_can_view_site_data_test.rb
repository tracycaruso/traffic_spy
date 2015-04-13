require './test/test_helper'

class UserViewsSiteDataTest < FeatureTest
  def test_user_views_identifier
    within ('header'){
      visit '/sources/jumpstartlab'
      assert page.has_content?("jumpstartlab")
    }
  end

  def test_user_can_use_side_nav
    visit '/sources/jumpstartlab'
    within ('aside'){
        assert page.has_content?("Event Data")
        assert page.has_content?("Dashboard")
        click_link_or_button("Event Data")
    }
    assert_equal '/sources/jumpstartlab/events', current_path
  end

  def test_user_views_browser_data
    visit '/sources/jumpstartlab'
    within ('.browsers'){
        assert page.has_content?("Chrome")
        assert page.has_content?("Safari")
    }
  end

  def test_user_views_platform_data
    visit '/sources/jumpstartlab'
    within ('.platforms'){
        assert page.has_content?("Macintosh%3B Intel Mac OS X 10_8_2")
    }
  end

  def test_user_views_visited_urls
    visit '/sources/jumpstartlab'
    within ('.urls'){
        assert page.has_content?("http://jumpstartlab.com/blog")
        click_link_or_button("http://jumpstartlab.com/blog")
    }
    assert_equal '/sources/jumpstartlab/urls/blog', current_path

    visit '/sources/jumpstartlab'
    within ('.urls'){
        assert page.has_content?("http://jumpstartlab.com/courses")
        click_link_or_button("http://jumpstartlab.com/courses")
    }
    assert_equal '/sources/jumpstartlab/urls/courses', current_path
  end


  def test_user_views_average_response_time_data
    visit '/sources/jumpstartlab'
    within ('.response_time'){
        assert page.has_content?("http://jumpstartlab.com/home: 37")
        assert page.has_content?("http://jumpstartlab.com/courses: 37")
    }
  end

  def test_user_views_resolution_data
    visit '/sources/jumpstartlab'
    within ('.screen_resolutions'){
        assert page.has_content?("1920x1280")
        assert page.has_content?("1280x720")
    }
  end


end
