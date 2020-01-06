# frozen_string_literal: true

require 'portal_client'
require 'http-cookie'

module Portal
  # Portal Client
  #
  # Used for setting up a Portal session
  class Client
    def initialize(host, username, password)
      @api = PortalClient::DefaultApi.new(
        PortalClient::ApiClient.new(
          PortalClient::Configuration.new { |c| c.host = host }
        )
      )
      @username = username
      @password = password
    end

    def session
      _, _, headers =
        @api
        .api_authenticate_post_with_http_info(
          email: @username, password: @password
        )

      cookies = HTTP::Cookie.parse(headers.fetch('set-cookie'), url)

      @api.api_client.default_headers['cookie'] =
        HTTP::Cookie.cookie_value(cookies)
      @api
    end

    attr_reader :api

    private

    def url
      @api.api_client.config.base_url
    end
  end
end
