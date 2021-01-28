require 'fakeweb'
FakeWeb.allow_net_connect = false

def fake_post path, response
  FakeWeb.register_uri(:post, "https://pi.pardot.com#{path}", :body => response)
end

def fake_get path, response
  FakeWeb.register_uri(:get, "https://pi.pardot.com#{path}", :body => response)
end

def fake_authenticate client, api_key
  client.api_key = api_key
end

def assert_authorization_header auth_manager
  expect(FakeWeb.last_request[:authorization]).to eq(auth_manager.expected_authorization_header)
  if auth_manager.has_business_unit_id_header? then
    expect(FakeWeb.last_request['Business-Unit-Id']).to eq(auth_manager.expected_business_unit_id_header)
  end
end