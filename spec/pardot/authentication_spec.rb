# frozen_string_literal: true

require File.expand_path("#{File.dirname(__FILE__)}/../spec_helper")

describe Pardot::Authentication do
  def create_client
    @client = Pardot::Client.new 'user@test.com', 'foo', 'bar'
  end

  def create_client_using_salesforce_access_token
    @client = Pardot::Client.new nil, nil, nil, 3, 'access_token_value', '0Uv000000000001CAA'
  end

  describe 'authenticate with Salesforce access_token' do
    before do
      @client = create_client_using_salesforce_access_token
    end

    it 'raises error when calling authenticate' do
      expect do
        @client.authenticate
      end.to raise_error.with_message(/Authentication not available when using Salesforce access token/)
    end

    it 'raises error when calling reauthenticate' do
      expect do
        @client.reauthenticate
      end.to raise_error.with_message(/Reauthentication not available when using Salesforce access token/)
    end

    it 'returns true for authenticated' do
      expect(@client.authenticated?).to eq(true)
    end

    it 'returns true for using_salesforce_access_token' do
      expect(@client.using_salesforce_access_token?).to eq(true)
    end
  end

  describe 'authenticate' do
    before do
      @client = create_client

      fake_post '/api/login/version/3',
                %(<?xml version="1.0" encoding="UTF-8"?>\n<rsp stat="ok" version="1.0">\n   <api_key>my_api_key</api_key>\n</rsp>\n)
    end

    def authenticate
      @client.authenticate
    end

    def verify_body
      expect(FakeWeb.last_request.body).to eq('email=user%40test.com&password=foo&user_key=bar')
    end

    it 'should return the api key' do
      expect(authenticate).to eq('my_api_key')
    end

    it 'should set the api key' do
      authenticate
      expect(@client.api_key).to eq('my_api_key')
      verify_body
    end

    it 'should make authenticated? true' do
      authenticate
      expect(@client.authenticated?).to eq(true)
      verify_body
    end

    it 'should use version 3' do
      authenticate
      expect(@client.version.to_i).to eq(3)
      verify_body
    end

    it 'returns false for using_salesforce_access_token' do
      expect(@client.using_salesforce_access_token?).to eq(false)

      authenticate
      expect(@client.using_salesforce_access_token?).to eq(false)
      verify_body
    end
  end

  describe 'authenticateV4' do
    before do
      @client = create_client

      fake_post '/api/login/version/3',
                %(<?xml version="1.0" encoding="UTF-8"?>\n<rsp stat="ok" version="1.0">\n   <api_key>my_api_key</api_key>\n<version>4</version>\n</rsp>\n)
    end

    def authenticate
      @client.authenticate
    end

    def verify_body
      expect(FakeWeb.last_request.body).to eq('email=user%40test.com&password=foo&user_key=bar')
    end

    it 'should return the api key' do
      expect(authenticate).to eq('my_api_key')
    end

    it 'should set the api key' do
      authenticate
      expect(@client.api_key).to eq('my_api_key')
      verify_body
    end

    it 'should make authenticated? true' do
      authenticate
      expect(@client.authenticated?).to eq(true)
      verify_body
    end

    it 'should use version 4' do
      authenticate
      expect(@client.version.to_i).to eq(4)
      verify_body
    end
  end
end
