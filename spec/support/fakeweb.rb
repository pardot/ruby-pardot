require 'fakeweb'
FakeWeb.allow_net_connect = false

def fake_post path, response
  content_type = (/login/ === path) ? 'text/xml' : 'application/json'
  FakeWeb.register_uri(:post, "https://pi.pardot.com#{path}", :body => response, :content_type => content_type)
end

def fake_get path, response
  FakeWeb.register_uri(:get, "https://pi.pardot.com#{path}", :body => response, :content_type => 'application/json')
end

def fake_authenticate client, api_key
  client.api_key = api_key
end
