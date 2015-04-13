module TrafficSpy
  class Source < ActiveRecord::Base
    validates :identifier, presence: true
    validates :root_url, presence: true

    has_many :payloads
    has_many :urls, through: :payloads

    def urls
      payloads.order('url_id').map { |pl| pl.url.name }
    end

    def ordered_urls
      frequency = urls.reduce(Hash.new(0)) { |h, v| h[v] += 1; h}
      urls.uniq.sort_by {|v| frequency[v] }.reverse
    end

    def url_objects
      payloads.order('url_id').map { |pl| pl.url }.uniq
    end

    def browsers
      payloads.order('user_agent_id').map { |pl| pl.user_agent.browser }.uniq
    end

    def platforms
      payloads.order('user_agent_id').map { |pl| pl.user_agent.platform }.uniq
    end

    def resolutions
      payloads.order('resolution_id').map { |pl| pl.resolution.dimension }.uniq
    end

    def ordered_url_response_times
      response_times = payloads.sort_by { |pl| pl.url.average_response_time }.reverse
      response_times.map { |pl| "#{pl.url.name}: #{pl.url.average_response_time}"}.uniq
    end

    def events
      events = Payload.pluck(:event_name_id)
      events.flat_map{|event| EventName.where(id: event).pluck(:name)}
    end

    def ordered_events
      payloads.order('event_name_id').map { |pl| pl.event_name.name }.uniq
    end

    def events_per_hour_count(event)
      sorted = events_per_hour(event).sort_by{|key, value| key}
      sorted.flat_map do |event|
        "Hour #{event[0]}: had #{event[1].count} event occurance(s)."
      end
    end

    def events_per_hour(event)
      payloads.where(event_name_id: event.id).group_by { |pl| Time.parse(pl.requested_at).hour }
    end

    def events_count(event)
      payloads.where(event_name_id: event.id).count
    end
  end
end
