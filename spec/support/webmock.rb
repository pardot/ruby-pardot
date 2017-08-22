require 'webmock/rspec'
include WebMock

def fake_post path, params_location, params, response
  stub_request(:post, "https://pi.pardot.com#{path}").
    with(params_location => URI.encode_www_form(params), headers: {'User-Agent'=>'Ruby'}).
    to_return(status: 200, body: response, headers: {})
end

def fake_get path, response
  stub_request(:get, "https://pi.pardot.com#{path}").
    to_return(status: 200, body: response, headers: {})
end

def fake_authenticate client, api_key
  client.api_key = api_key
end
