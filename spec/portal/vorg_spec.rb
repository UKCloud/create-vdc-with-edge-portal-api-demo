# frozen_string_literal: true
require 'json'
require 'net/http'
require 'portal/session'
require 'portal/vorg'
require 'webmock/rspec'

describe(Portal::Vorg) do
  let(:session_cookie) { 'user=blah' }
  let(:session_host) { 'portal.local' }
  let(:session_http_server) do
    Net::HTTP.new(session_host, Net::HTTP.http_default_port)
  end
  let(:session) do
    instance_double(
      Portal::Session,
      cookie: session_cookie,
      host: session_host,
      http_server: session_http_server
    )
  end
  let(:account_id) { 5 }
  let(:vorg_id) { 7 }
  let(:vorg) { described_class.new(session, account_id, vorg_id) }

  describe('#provision_vdc') do
    let(:vdc_name) { 'My VDC' }
    let(:vm_type) { 'POWER' }
    let(:provision_route) do
      "http://#{session_host}/api/accounts/#{account_id}/vorgs/#{vorg_id}/vdcs"
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
          }, headers: { 'Cookie' => session_cookie }
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
      describe('#session') do
        it { expect(provision_vdc!.session).to(equal(session)) }
      end
      describe('#route') do
        it { expect(provision_vdc!.route).to(eq(build_route)) }
      end
      describe('#state') do
        it { expect(provision_vdc!.state).to(eq(build_state)) }
      end
    end
    context('build rejected') do
      let(:response_body) { JSON.dump(nil) }
      let(:response_status) { 400 }
      it('raises an error') do
        expect { provision_vdc! }.to(raise_error(Portal::Error))
      end
    end
  end
end
