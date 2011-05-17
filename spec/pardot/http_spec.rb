require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Pardot::Http do
  
  before do
    @client = create_client
    fake_authenticate @client, "my_api_key"
  end
  
  def create_client
    @client = Pardot::Client.new "user@test.com", "foo", "bar"
  end
  
  describe "get" do
    
    def get object = "foo", path = "/bar", params = {}
      @client.get object, path, params
    end
    
    it "should notice errors and raise them as Pardot::ResponseError" do
      fake_get "/api/foo/version/3/bar?api_key=my_api_key&format=simple&user_key=bar",
               %(?xml version="1.0" encoding="UTF-8"?>\n<rsp stat="fail" version="1.0">\n   <err code="15">Login failed</err>\n</rsp>\n)
      
      lambda { get }.should raise_error(Pardot::ResponseError)
    end
    
    it "should catch and reraise SocketErrors as Pardot::NetError" do
      Pardot::Client.should_receive(:get).and_raise(SocketError)
      
      lambda { get }.should raise_error(Pardot::NetError)
    end
    
  end
  
  describe "post" do
    
    def post object = "foo", path = "/bar", params = {}
      @client.post object, path, params
    end
    
    it "should notice errors and raise them as Pardot::ResponseError" do
      fake_post "/api/foo/version/3/bar?api_key=my_api_key&format=simple&user_key=bar",
                %(?xml version="1.0" encoding="UTF-8"?>\n<rsp stat="fail" version="1.0">\n   <err code="15">Login failed</err>\n</rsp>\n)
      
      lambda { post }.should raise_error(Pardot::ResponseError)
    end
    
    it "should catch and reraise SocketErrors as Pardot::NetError" do
      Pardot::Client.should_receive(:post).and_raise(SocketError)
      
      lambda { post }.should raise_error(Pardot::NetError)
    end
    
  end
  
end