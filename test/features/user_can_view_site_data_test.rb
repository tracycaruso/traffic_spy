require './test/test_helper'
require './test/create_sources_and_payloads'

class UserViewsSiteDataTest < FeatureTest
  include CreateSourcesAndPayloads

  def test_user_views_identifier
    source = CreateSourcesAndPayloads.create_source("jumpstartlab", "http://www.jumpstartlab.com")
    CreateSourcesAndPayloads.create_payload("http://jumpstartlab.com/blog",
                                            "2014-02-16 21:38:28 -0700",
                                            10,
                                            "http://jumpstartlab.com",
                                            "GET",
                                            [],
                                            "socialLogin",
                                            "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                                            "1920",
                                            "1280",
                                            "63.29.38.211",
                                            source)
    CreateSourcesAndPayloads.create_payload("http://jumpstartlab.com/blog",
                                            "2014-03-16 21:38:30 -0700",
                                            20,
                                            "http://jumpstartlab.com",
                                            "GET",
                                            [],
                                            "socialLogin",
                                            "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                                            "1920",
                                            "1280",
                                            "63.29.38.211",
                                            source)
    CreateSourcesAndPayloads.create_payload("http://jumpstartlab.com/courses",
                                            "2015-03-16 21:38:00 -0800",
                                            37,
                                            "http://jumpstartlab.com",
                                            "GET",
                                            [],
                                            "socialLogin",
                                            "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Safari/24.0.1309.0 Safari/537.17",
                                            "1280",
                                            "720",
                                            "63.29.38.210",
                                            source)


    #as a client
    #When I visit the page for my site
    visit '/sources/jumpstartlab'
    #I expect to see the identifier for my site
    assert page.has_content?("jumpstartlab")
    within ('ul.urls li:nth-child(1)'){
        assert page.has_content?("http://jumpstartlab.com/blog")
    }
    within ('ul.urls li:nth-child(2)'){
        assert page.has_content?("http://jumpstartlab.com/courses")
    }
    within ('ul.average_urls li:nth-child(1)'){
        assert page.has_content?("http://jumpstartlab.com/courses: 37")
    }
    within ('ul.average_urls li:nth-child(2)'){
        assert page.has_content?("http://jumpstartlab.com/blog: 15")
    }
    within ('ul.browsers li:nth-child(1)'){
        assert page.has_content?("Chrome")
    }

    within ('ul.browsers li:nth-child(3)'){
        assert page.has_content?("Safari")
    }

    within ('ul.screen_resolutions li:nth-child(1)'){
        assert page.has_content?("1920x1280")
    }

    within ('ul.screen_resolutions li:nth-child(3)'){
        assert page.has_content?("1280x720")
    }

    within ('ul.urls li:nth-child(1)'){
      #click_link_or_button("jumpstartlab.com/blog")
      # assert_equal 'sources/jumpstartlab/urls/blog', current_path
    }

    within('.single_url'){
      click_link_or_button("http://jumpstartlab.com/blog")}
      assert_equal '/sources/jumpstartlab/urls/blog', current_path
      assert page.has_content?("jumpstartlab")
      assert page.has_content?("20")
      assert page.has_content?("15")
      assert page.has_content?("10")
      assert page.has_content?("Chrome")


    visit '/sources/jumpstartlab/urls/peanuts'
    within('h1'){
      assert page.has_content?("Message that the url has not been requested")
    }

  end

end
