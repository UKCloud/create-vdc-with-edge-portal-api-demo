# frozen_string_literal: true

require 'portal_client'
require 'portal/vorg'
require 'webmock/rspec'

describe(Portal::Vorg) do
  let(:session_host) { 'portal.local' }

  let(:session) do
    PortalClient::DefaultApi.new(
      PortalClient::ApiClient.new(
        PortalClient::Configuration.new { |c| c.host = session_host }
      )
    )
  end
  let(:account_id) { '5' }
  let(:vorg_id) { '7' }
  let(:vorg) { described_class.new(session, account_id, vorg_id) }

  describe('#provision_vdc') do
    let(:vdc_name) { 'My VDC' }
    let(:vm_type) { 'POWER' }
    let(:provision_route) do
      "https://#{session_host}/api/accounts/#{account_id}/vorgs/#{vorg_id}/vdcs"
    end
    let(:provision_vdc!) { vorg.provision_vdc(vdc_name, vm_type) }
    let(:build_route) { '/api/vdc-builds/42' }
    before do
      stub_request(:post, provision_route)
        .with(
          body: {
            data: {
              type: 'VDC', attributes: { name: vdc_name, vmType: vm_type }
            }
          }
        )
        .to_return(
          status: response_status, body: response_body,
          headers: { 'Location' => build_route }
        )
    end
    context('build accepted') do
      let(:build_state) { 'approved' }
      let(:response_body) do
        JSON.dump(
          data: {
            type: 'VDC-build',
            id: 8,
            attributes: {
              state: build_state
            }
          }
        )
      end
      let(:response_status) { 202 }
      it('sends the correct HTTP message') do
        provision_vdc!
        expect(WebMock).to(have_requested(:post, provision_route))
      end
      it('returns a build object') do
        expect(provision_vdc!).to(be_a(Portal::Build))
      end
      describe('#reload_proc') do
        it do
          expect(provision_vdc!.reload_proc).to(
            eq(session.method(:api_vdc_builds_build_id_get))
          )
        end
      end
      describe('#state') do
        it { expect(provision_vdc!.state).to(eq(build_state)) }
      end
    end
    context('build rejected') do
      let(:response_body) { JSON.dump(nil) }
      let(:response_status) { 400 }
      it('raises an error') do
        expect { provision_vdc! }.to(raise_error(PortalClient::ApiError))
      end
    end
  end
end
