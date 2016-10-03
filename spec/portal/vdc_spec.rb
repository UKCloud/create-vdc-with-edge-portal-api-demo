# frozen_string_literal: true
require 'portal/vdc'
require 'webmock/rspec'

describe(Portal::Vdc) do
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
  let(:vdc_urn) { 'urn:vcloud:vdc:345a5d90-1c8c-4fb2-bf4f-f480de82c594' }
  let(:vdc) { described_class.new(session, account_id, vorg_id, vdc_urn) }

  describe('#provision_internet_edge_gateway') do
    let(:provision_route) do
      "http://#{session_host}/api/accounts/#{account_id}/vorgs/#{vorg_id}" \
      "/vdcs/#{vdc_urn}/edge-gateways"
    end
    let(:provision_internet_edge_gateway!) do
      vdc.provision_internet_edge_gateway
    end
    let(:build) { provision_internet_edge_gateway! }
    let(:build_route) { '/api/edge-builds/42' }
    before do
      stub_request(:post, provision_route)
        .with(
          body: {
            data: {
              type: 'EdgeGateway', attributes: { connectivityType: 'Internet' }
            }
          }, headers: { 'Cookie' => session_cookie }
        )
        .to_return(
          status: response_status, body: response_body,
          headers: { 'Location' => build_route }
        )
    end
    context('unsuccessful') do
      let(:response_status) { 400 }
      let(:response_body) { JSON.dump(nil) }
      it('raises an error') do
        expect { provision_internet_edge_gateway! }
          .to(raise_error(Portal::Error))
      end
    end
    context('successful') do
      let(:response_status) { 202 }
      let(:build_state) { 'approved' }
      let(:response_body) do
        JSON.dump(
          data: {
            type: 'EdgeGateway-build',
            id: 8,
            attributes: {
              state: build_state
            }
          }
        )
      end
      it('sends the correct HTTP message') do
        provision_internet_edge_gateway!
        expect(WebMock).to(have_requested(:post, provision_route))
      end
      it('returns a build object') do
        expect(provision_internet_edge_gateway!).to(be_a(Portal::Build))
      end
      describe('#session') do
        it { expect(build.session).to(equal(session)) }
      end
      describe('#route') do
        it { expect(build.route).to(eq(build_route)) }
      end
      describe('#state') do
        it { expect(build.state).to(eq(build_state)) }
      end
    end
  end
end
