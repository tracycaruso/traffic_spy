require 'json'
require 'byebug'

module TrafficSpy
  class Server < Sinatra::Base
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

      @url = Url.find_by(name: "http://#{identifier}.com/#{path}")

      # puts @url.inspect
      # puts @url.name
      # urls = Url.all
      # urls.each {|url| puts url.name}
      # puts "http://#{identifier}.com/#{path}"

      @identifier = identifier

      if @url == nil
        erb :url_not_requested
      else
        erb :url_data
      end
    end

    # get '/sources/:identifier/events' do |identifier|
    #   # @events = Payload.pluck(identifier: identifier).events
    #
    #   if @event == nil
    #     erb :no_event_error
    #   else
    #     erb :event_data
    #   end
    # end



    post '/sources/:identifier/data' do |identifier|
      payload_helper = PayloadHelper.call(params, identifier)
      status PayloadHelper.status
      body   PayloadHelper.body
    end
  end
end
