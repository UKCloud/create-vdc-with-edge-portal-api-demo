# frozen_string_literal: true

require_relative 'build'

module Portal
  # Represents VDCs within the Portal API
  #
  # Used for provisioning edge gateways
  class Vdc
    def initialize(session, account_id, vorg_id, vdc_urn)
      @session = session
      @account_id = account_id.to_i
      @vorg_id = vorg_id.to_i
      @vdc_urn = vdc_urn
    end

    def provision_internet_edge_gateway
      response =
        @session
        .api_accounts_account_id_vorgs_vorg_id_vdcs_vdc_urn_edge_gateways_post(
          @account_id, @vorg_id, @vdc_urn, data: {
            type: 'EdgeGateway', attributes: { connectivityType: 'Internet' }
          }
        )

      Build.new(
        @session.method(:api_edge_gateway_builds_build_id_get), response.data
      )
    end
  end
end
