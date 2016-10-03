# frozen_string_literal: true
require 'json'

module Portal
  # Represents a build within the Portal
  #
  # It is flexible enough to work with VDC builds and Edge Gateway builds.
  class Build
    def initialize(session, route, json_data)
      @session = session
      @route = route
      @json_data = json_data
    end

    attr_reader :route, :session

    def state
      parsed_data['data']['attributes']['state']
    end

    def reload
      response = session.http_server.request(reload_request)
      Build.new(session, route, response.body)
    end

    def done?
      succeeded? || failed?
    end

    def succeeded?
      state == 'completed'
    end

    def failed?
      state == 'failed'
    end

    private

    def parsed_data
      JSON.parse(@json_data)
    end

    def reload_request
      Net::HTTP::Get.new(reload_url).tap do |request|
        request['Cookie'] = session.cookie
      end
    end

    def reload_url
      URI::HTTPS.build(host: session.host, path: route)
    end
  end
end
