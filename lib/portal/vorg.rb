# frozen_string_literal: true

require 'net/http'
require 'uri'
require_relative 'build'
require_relative 'error'

module Portal
  # A Vorg within the Portal API
  class Vorg
    def initialize(session, account_id, vorg_id)
      @session = session
      @account_id = account_id
      @vorg_id = vorg_id
    end

    def provision_vdc(vdc_name, vm_type)
      response =
        @session.http_server.request(provision_vdc_request(vdc_name, vm_type))
      case response
      when Net::HTTPClientError
        raise Error
      end
      Build.new(@session, response['Location'], response.body)
    end

    private

    def provision_vdc_request(vdc_name, vm_type)
      Net::HTTP::Post.new(provision_vdc_url).tap do |request|
        request['content-type'] = 'application/json'
        request['Cookie'] = @session.cookie
        request.body = JSON.generate(
          data: {
            type: 'VDC',
            attributes: { name: vdc_name, vmType: vm_type }
          }
        )
      end
    end

    def provision_vdc_url
      URI::HTTPS.build(
        host: @session.host,
        path: "/api/accounts/#{@account_id}/vorgs/#{@vorg_id}/vdcs"
      )
    end
  end
end
