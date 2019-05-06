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

def assert_authorization_header
  expect(FakeWeb.last_request[:authorization]).to eq('Pardot api_key=my_api_key, user_key=bar')
end