=begin
#UKCloud Portal API

#No description provided (generated by Openapi Generator https://github.com/openapitools/openapi-generator)

The version of the OpenAPI document: development

Generated by: https://openapi-generator.tech
OpenAPI Generator version: 4.2.2

=end

require 'spec_helper'
require 'json'
require 'date'

# Unit tests for PortalClient::VOrgBuilds
# Automatically generated by openapi-generator (https://openapi-generator.tech)
# Please update as you see appropriate
describe 'VOrgBuilds' do
  before do
    # run before each test
    @instance = PortalClient::VOrgBuilds.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of VOrgBuilds' do
    it 'should create an instance of VOrgBuilds' do
      expect(@instance).to be_instance_of(PortalClient::VOrgBuilds)
    end
  end
  describe 'test attribute "data"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

end
