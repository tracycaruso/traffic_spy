module TrafficSpy
  class EventName < ActiveRecord::Base
    has_many :payloads

    def events
      events = Payload.pluck(:event_name_id)
      events.flat_map{|event| EventName.where(id: event).pluck(:name)}
    end

    def ordered_events
      frequency = events.reduce(Hash.new(0)) { |h, v| h[v] += 1; h}
      events.uniq.sort_by {|v| frequency[v] }.reverse
    end
    

  end
end
