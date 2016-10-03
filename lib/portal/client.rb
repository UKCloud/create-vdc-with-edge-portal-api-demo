# frozen_string_literal: true
require 'http-cookie'
require 'json'
require 'net/http'
require 'uri'

require_relative 'invalid_authentication_error'
require_relative 'session'

module Portal
  # Portal Client
  #
  # Used for setting up a Portal session
  class Client
    def initialize(host, username, password)
      @host = host
      @username = username
      @password = password
    end

    def session
      response = http_server.request(session_request)
      case response
      when Net::HTTPUnauthorized
        raise InvalidAuthenticationError
      when Net::HTTPSuccess
        Session.new(self, cookie_jar(response))
      end
    end

    def http_server
      Net::HTTP.new(@host, Net::HTTP.https_default_port).tap do |http|
        http.use_ssl = true
        # if we decide to not check ssl certificates then
        # require 'openssl'
        # http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
    end

    attr_reader :host

    private

    def session_request
      Net::HTTP::Post.new(session_url).tap do |request|
        request['content-type'] = 'application/json'
        request.body = JSON.generate(email: @username, password: @password)
      end
    end

    def cookie_jar(response)
      HTTP::CookieJar.new.tap do |jar|
        response.header.get_fields('set-cookie').each do |cookie_string|
          jar.parse(cookie_string, session_url)
        end
      end
    end

    def session_url
      URI::HTTPS.build(host: @host, path: '/api/authenticate')
    end
  end
end
