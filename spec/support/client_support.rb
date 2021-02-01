# frozen_string_literal: true

def create_auth_managers
  [UsernamePasswordAuthManager.new, SalesforceAccessTokenAuthManager.new]
end

class UsernamePasswordAuthManager
  attr_accessor :test_name_suffix, :expected_authorization_header

  def initialize
    @test_name_suffix = 'With UsernamePassword Auth'
    @expected_authorization_header = 'Pardot api_key=my_api_key, user_key=bar'
  end

  def create_client
    client = Pardot::Client.new 'user@test.com', 'foo', 'bar'
    client.api_key = 'my_api_key'
    client
  end

  def has_business_unit_id_header?
    false
  end
end

class SalesforceAccessTokenAuthManager
  attr_accessor :test_name_suffix, :expected_authorization_header, :expected_business_unit_id_header

  def initialize
    @test_name_suffix = 'With Salesforce OAuth'
    @expected_authorization_header = 'Bearer access_token_value'
    @expected_business_unit_id_header = '0Uv000000000001CAA'
  end

  def create_client
    Pardot::Client.new nil, nil, nil, 3, 'access_token_value', '0Uv000000000001CAA'
  end

  def has_business_unit_id_header?
    false
  end
end
