# frozen_string_literal: true

require File.expand_path("#{File.dirname(__FILE__)}/../spec_helper")

describe Pardot::Client do
  def create_client
    @client = Pardot::Client.new 'user@test.com', 'foo', 'bar'
  end

  describe 'client with Salesforce access_token' do
    it 'should set properties' do
      @client = Pardot::Client.new nil, nil, nil, 3, 'access_token_value', '0Uv000000000001CAA'
      expect(@client.email).to eq(nil)
      expect(@client.password).to eq(nil)
      expect(@client.user_key).to eq(nil)
      expect(@client.api_key).to eq(nil)
      expect(@client.version).to eq(3)
      expect(@client.salesforce_access_token).to eq('access_token_value')
      expect(@client.business_unit_id).to eq('0Uv000000000001CAA')
      expect(@client.format).to eq('simple')
    end

    it 'raises error with nil business_unit_id' do
      expect do
        Pardot::Client.new nil, nil, nil, 3, 'access_token_value',
                           nil
      end.to raise_error.with_message(/business_unit_id required when using Salesforce access_token/)
    end

    it 'raises error with invalid business_unit_id due to length' do
      expect do
        Pardot::Client.new nil, nil, nil, 3, 'access_token_value',
                           '0Uv1234567890'
      end.to raise_error.with_message(/Invalid business_unit_id value. Expected ID to start with '0Uv' and be length of 18 characters./)
    end

    it 'raises error with invalid business_unit_id due to invalid prefix' do
      expect do
        Pardot::Client.new nil, nil, nil, 3, 'access_token_value',
                           '001000000000001AAA'
      end.to raise_error.with_message(/Invalid business_unit_id value. Expected ID to start with '0Uv' and be length of 18 characters./)
    end
  end

  describe 'client' do
    after do
      expect(@client.email).to eq('user@test.com')
      expect(@client.password).to eq('password')
      expect(@client.user_key).to eq('user_key')
      expect(@client.format).to eq('simple')
    end

    it 'should set variables without version' do
      @client = Pardot::Client.new 'user@test.com', 'password', 'user_key'
      expect(@client.version).to eq(3)
    end

    it 'should set variables with version' do
      @client = Pardot::Client.new 'user@test.com', 'password', 'user_key', 4
      expect(@client.version).to eq(4)
    end
  end

  describe '#base_uri' do
    context 'without PARDOT_URL' do
      before do
        ENV.delete('PARDOT_URL')
      end

      it 'return default value' do
        expect(Pardot::Client.base_uri).to eq('https://pi.pardot.com')
      end
    end

    context 'with PARDOT_URL' do
      before do
        ENV['PARDOT_URL'] = 'https://pi.demo.pardot.com'
      end

      it 'return ENV value' do
        expect(Pardot::Client.base_uri).to eq('https://pi.pardot.com')
      end
    end
  end
end
