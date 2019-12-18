# frozen_string_literal: true

require 'net/http'
require 'portal/build'
require 'portal/session'
require 'webmock/rspec'

describe(Portal::Build) do
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

  let(:route) { '/api/xyz-builds/10' }
  let(:initial_state) { 'approved' }
  let(:initial_json_data) do
    <<-JSON
    {
        "data": {
            "attributes": {
                "state": "#{initial_state}"
            }
        }
    }
    JSON
  end

  let(:build) { described_class.new(session, route, initial_json_data) }

  describe('#state') do
    it { expect(build.state).to(eq(initial_state)) }
  end

  describe('#session') do
    it { expect(build.session).to(equal(session)) }
  end

  describe('#route') do
    it { expect(build.route).to(equal(route)) }
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
    let(:reload_route) { "http://#{session_host}#{route}" }

    before do
      stub_request(:get, reload_route)
        .with(headers: { 'Cookie' => session_cookie })
        .to_return(status: response_status, body: reloaded_json_data)
    end

    context('successful') do
      let(:reloaded_state) { 'running' }
      let(:reloaded_json_data) do
        <<-JSON
        {
          "data": {
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
