# frozen_string_literal: true

require_relative 'build'

module Portal
  # A Vorg within the Portal API
  class Vorg
    def initialize(session, account_id, vorg_id)
      @session = session
      @account_id = account_id.to_i
      @vorg_id = vorg_id.to_i
    end

    def provision_vdc(vdc_name, vm_type)
      response = @session.api_accounts_account_id_vorgs_vorg_id_vdcs_post(
        @account_id, @vorg_id, data: {
          type: 'VDC',
          attributes: { name: vdc_name, vmType: vm_type }
        }
      )
      Build.new(
        @session.method(:api_vdc_builds_build_id_get), response.data
      )
    end
  end
end
