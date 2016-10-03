# frozen_string_literal: true
require 'http-cookie'
require 'portal/client'
require 'webmock/rspec'

describe(Portal::Client) do
  let(:host) { 'portal.example' }
  let(:username) { 'ccouzens@ukcloud.com' }
  let(:password) { 'mypassword' }

  let(:client) { described_class.new(host, username, password) }

  describe('#host') do
    it { expect(client.host).to(eq(host)) }
  end

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
        { 'set-cookie' => 'rack.session=BAh; path=/api; HttpOnly; secure' }
      end
      let(:status) { 200 }
      it { is_expected.to(be_a(Portal::Session)) }
      describe('#client') do
        it('equals original client') do
          expect(session.client).to(equal(client))
        end
      end
      describe('#cookie_jar') do
        let('cookie_jar') { session.cookie_jar }
        it('has the expected value') do
          expect(HTTP::Cookie.cookie_value(cookie_jar.cookies(login_route)))
            .to(eq('rack.session=BAh'))
        end
      end
    end

    context('authentication unsuccessful') do
      let(:headers) { {} }
      let(:status) { 401 }
      it('raises error') do
        expect { subject }.to(raise_error(Portal::Error))
      end
      it('raises invalid authentication error') do
        expect { subject }.to(raise_error(Portal::InvalidAuthenticationError))
      end
    end
  end

  describe('#http_server') do
    let(:http_server) { client.http_server }
    describe('#address') do
      it { expect(http_server.address).to(eq(host)) }
    end
    describe('#port') do
      it { expect(http_server.port).to(eq(443)) }
    end
    describe('#use_ssl?') do
      it { expect(http_server.use_ssl?).to(be(true)) }
    end
  end
end
