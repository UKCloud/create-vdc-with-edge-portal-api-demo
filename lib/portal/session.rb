# frozen_string_literal: true
module Portal
  # Portal Session
  #
  # An authenticated connection to the Portal
  class Session
    def initialize(client, cookie_jar)
      @client = client
      @cookie_jar = cookie_jar
    end

    def host
      client.host
    end

    def http_server
      client.http_server
    end

    def cookie
      HTTP::Cookie.cookie_value(cookie_jar.cookies)
    end

    attr_reader :client, :cookie_jar
  end
end
