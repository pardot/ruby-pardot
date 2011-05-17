
def create_client
  @client = Pardot::Client.new "user@test.com", "foo", "bar"
  @client.api_key = "my_api_key"
  @client
end
