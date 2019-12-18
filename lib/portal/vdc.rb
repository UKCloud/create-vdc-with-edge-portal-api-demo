# frozen_string_literal: true

require 'net/http'
require 'uri'
require_relative 'build'
require_relative 'error'

module Portal
  # Represents VDCs within the Portal API
  #
  # Used for provisioning edge gateways
  class Vdc
    def initialize(session, account_id, vorg_id, vdc_urn)
      @session = session
      @account_id = account_id
      @vorg_id = vorg_id
      @vdc_urn = vdc_urn
    end

    def provision_internet_edge_gateway
      response =
        @session.http_server.request(provision_internet_edge_gateway_request)
      case response
      when Net::HTTPClientError
        raise Error
      end
      Build.new(@session, response['Location'], response.body)
    end

    private

    def provision_internet_edge_gateway_request
      Net::HTTP::Post.new(provision_edge_gateway_url).tap do |request|
        request['content-type'] = 'application/json'
        request['Cookie'] = @session.cookie
        request.body = JSON.generate(
          data: {
            type: 'EdgeGateway',
            attributes: { connectivityType: 'Internet' }
          }
        )
      end
    end

    def provision_edge_gateway_url
      URI::HTTPS.build(
        host: @session.host,
        path: "/api/accounts/#{@account_id}/vorgs/#{@vorg_id}" \
        "/vdcs/#{@vdc_urn}/edge-gateways"
      )
    end
  end
end
