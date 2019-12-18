# frozen_string_literal: true

require 'http-cookie'
require 'net/http'
require 'portal/session'
require 'portal/client'

describe(Portal::Session) do
  let(:client_host) { 'www.google.com' }
  let(:client_http_server) { instance_double(Net::HTTP) }
  let(:client) do
    instance_double(
      Portal::Client, host: client_host, http_server: client_http_server
    )
  end
  let(:cookie_jar) { instance_double(HTTP::CookieJar) }
  let(:session) { described_class.new(client, cookie_jar) }
  describe('#client') do
    it('matches the original client') { expect(session.client).to(eq(client)) }
  end

  describe('#cookie_jar') do
    it('matches the original cookie-jar') do
      expect(session.cookie_jar).to(eq(cookie_jar))
    end
  end

  describe('#host') do
    it('matches the original client-host') do
      expect(session.host).to(eq(client_host))
    end
  end

  describe('#http_server') do
    it('matches the original client-http-server') do
      expect(session.http_server).to(eq(client_http_server))
    end
  end

  describe('#cookie') do
    let(:rack_cookie_value) { '84a5c' }
    let(:cookie_string) do
      "rack.session=#{rack_cookie_value}; path=/api; HttpOnly; secure"
    end
    let(:cookie_jar) do
      HTTP::CookieJar.new.tap do |jar|
        jar.parse(cookie_string, "https://#{client_host}/api")
      end
    end
    subject { session.cookie }
    it { is_expected.to(eq("rack.session=#{rack_cookie_value}")) }
  end
end
