# frozen_string_literal: true

require 'portal/build'
require 'webmock/rspec'
require 'portal_client'

describe(Portal::Build) do
  let(:session_host) { 'portal.local' }
  let(:api) do
    PortalClient::DefaultApi.new(
      PortalClient::ApiClient.new(
        PortalClient::Configuration.new { |c| c.host = session_host }
      )
    )
  end

  let(:reload_proc) { api.method(:api_vdc_builds_build_id_get) }
  let(:initial_state) { 'approved' }
  let(:id) { '3' }
  let(:initial_data) do
    PortalClient::VdcBuildResponse.new(
      id: id,
      attributes:
      PortalClient::VdcBuildResponseAttributes.new(
        state: initial_state
      )
    )
  end

  let(:build) { described_class.new(reload_proc, initial_data) }

  describe('#state') do
    it { expect(build.state).to(eq(initial_state)) }
  end

  describe('#reload_proc') do
    it { expect(build.reload_proc).to(equal(reload_proc)) }
  end

  context('when approved') do
    let(:initial_state) { 'approved' }
    describe('#done?') { it { expect(build.done?).to(eq(false)) } }
    describe('#succeeded?') { it { expect(build.succeeded?).to(eq(false)) } }
    describe('#failed?') { it { expect(build.failed?).to(eq(false)) } }
  end

  context('when completed') do
    let(:initial_state) { 'completed' }
    describe('#done?') { it { expect(build.done?).to(eq(true)) } }
    describe('#succeeded?') { it { expect(build.succeeded?).to(eq(true)) } }
    describe('#failed?') { it { expect(build.failed?).to(eq(false)) } }
  end

  context('when failed') do
    let(:initial_state) { 'failed' }
    describe('#done?') { it { expect(build.done?).to(eq(true)) } }
    describe('#succeeded?') { it { expect(build.succeeded?).to(eq(false)) } }
    describe('#failed?') { it { expect(build.failed?).to(eq(true)) } }
  end

  describe('#reload') do
    let(:reload_route) { "https://#{session_host}/api/vdc-builds/#{id}" }

    before do
      stub_request(:get, reload_route)
        .to_return(status: response_status, body: reloaded_json_data)
    end

    context('successful') do
      let(:reloaded_state) { 'running' }
      let(:reloaded_json_data) do
        <<-JSON
        {
          "data": {
            "id": "#{id}",
            "attributes": {
              "state": "#{reloaded_state}"
            }
          }
        }
        JSON
      end

      let(:response_status) { 200 }

      it('calls the correct HTTP route') do
        build.reload
        expect(WebMock).to(have_requested(:get, reload_route))
      end

      it('returns a build object') do
        expect(build.reload).to(be_a(described_class))
      end

      it('has the new state') do
        expect(build.reload.state).to(eq(reloaded_state))
      end

      it('does not change the original object') do
        build.reload
        expect(build.state).to(eq(initial_state))
      end
    end
  end
end
