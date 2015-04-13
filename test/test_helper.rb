ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara'
require 'database_cleaner'
require 'json'
require 'tilt/erb'
require './test/create_sources_and_payloads'

DatabaseCleaner.strategy = :truncation, {except: %w[public.schema_migrations]}

Capybara.app = TrafficSpy::Server

class Minitest::Test
  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end
end

class FeatureTest < Minitest::Test
  include Capybara::DSL

  include CreateSourcesAndPayloads
  def setup
    source = CreateSourcesAndPayloads.create_source("jumpstartlab", "http://www.jumpstartlab.com")

    CreateSourcesAndPayloads.create_payload("http://jumpstartlab.com/blog", "2014-02-16 21:38:28 -0700", 10,
                                            "http://jumpstartlab.com", "GET", [], "socialLogin",
                                            "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                                            "1920", "1280", "63.29.38.215", source)

    CreateSourcesAndPayloads.create_payload("http://jumpstartlab.com/blog", "2014-03-16 21:38:30 -0700", 20,
                                            "http://jumpstartlab.com", "POST", [], "submit",
                                            "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                                            "1920", "1280", "63.29.38.211", source)

    CreateSourcesAndPayloads.create_payload("http://jumpstartlab.com/courses","2013-03-16 21:38:00 -0800", 37,
                                            "http://jumpstartlab.com", "GET",[],"socialLogin",
                                            "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Safari/24.0.1309.0 Safari/537.17",
                                            "1280", "720","63.29.38.212",source)

    CreateSourcesAndPayloads.create_payload("http://jumpstartlab.com/courses","2012-03-16 21:38:00 -0800", 37,
                                            "http://jumpstartlab.com", "POST",[],"delete",
                                            "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Safari/24.0.1309.0 Safari/537.17",
                                            "1280", "720","63.29.38.211",source)

    CreateSourcesAndPayloads.create_payload("http://jumpstartlab.com/home","2011-03-16 21:38:00 -0800", 37,
                                            "http://jumpstartlab.com", "POST",[],"delete",
                                            "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Safari/24.0.1309.0 Safari/537.17",
                                            "1280", "720","63.29.37.211",source)
    end
  end

class ControllerTest < Minitest::Test
  include Rack::Test::Methods
end
