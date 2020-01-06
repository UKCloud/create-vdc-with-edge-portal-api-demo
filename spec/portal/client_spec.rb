# frozen_string_literal: true

require 'portal/client'
require 'webmock/rspec'

describe(Portal::Client) do
  let(:host) { 'portal.example' }
  let(:username) { 'ccouzens@ukcloud.com' }
  let(:password) { 'mypassword' }

  let(:client) { described_class.new(host, username, password) }

  describe('#session') do
    let(:login_route) { "https://#{host}/api/authenticate" }
    let(:session) { client.session }
    subject { session }
    before do
      stub_request(:post, login_route)
        .with(body: { email: username, password: password })
        .to_return(headers: headers, status: status)
    end

    context('authentication successful') do
      it('sends the correct HTTP message') do
        session
        expect(WebMock).to(have_requested(:post, login_route))
      end
      let(:headers) do
        { 'set-cookie' => [
          'rack.session=BAh; path=/api; HttpOnly; secure', 'b=foo; path=/api'
        ] }
      end
      let(:status) { 200 }
      it { is_expected.to(be_a(PortalClient::DefaultApi)) }
      it('equals original api') do
        expect(session).to(equal(client.api))
      end
      it('has the cookies') do
        expect(session.api_client.default_headers['cookie'])
          .to(eq('b=foo; rack.session=BAh'))
      end
    end

    context('authentication unsuccessful') do
      let(:headers) { {} }
      let(:status) { 401 }
      it('raises error') do
        expect { subject }.to(raise_error(PortalClient::ApiError))
      end
    end
  end

  describe('#api') do
    let(:api) { client.api }
    describe('#api_client') do
      let(:api_client) { api.api_client }
      describe('#config') do
        let(:config) { api_client.config }
        describe('#base_url') do
          let(:base_url) { config.base_url }
          it { expect(base_url).to(eq("https://#{host}")) }
        end
      end
    end
  end
end
