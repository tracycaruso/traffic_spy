require 'json'
require 'byebug'

module TrafficSpy
  class Server < Sinatra::Base
    register Sinatra::Partial
    set :partial_template_engine, :erb

    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    post '/sources' do
      source_helper = SourceHelper.call(params)
      status SourceHelper.status
      body   SourceHelper.body
    end

    get '/sources/:identifier' do |identifier|
      @source = Source.find_by(identifier: identifier)
      if @source == nil
        erb :no_source_error
      else
        erb :aggregate_data
      end
    end



    get '/sources/:identifier/urls/:path' do |identifier, path|
      @source = Source.find_by(identifier: identifier)
      @url = Url.find_by(relative_path: "/#{path}")
      @identifier = identifier

      if @url == nil
        erb :url_not_requested
      else
        erb :url_data
      end
    end

    get '/sources/:identifier/events' do |identifier|
      @source = Source.find_by(identifier: identifier)
      if @source == nil
        erb :events_not_found
      else
        erb :event_data
      end
    end

    get '/sources/:identifier/events/:name' do |identifier, name|

      @source = Source.find_by(identifier: identifier)
      @event = EventName.find_by(name: name)
      if @event == nil
        erb :events_not_found
      else
        erb :event
      end
    end

    post '/sources/:identifier/data' do |identifier|
      payload_helper = PayloadHelper.call(params, identifier)
      status PayloadHelper.status
      body   PayloadHelper.body
    end
  end
end
