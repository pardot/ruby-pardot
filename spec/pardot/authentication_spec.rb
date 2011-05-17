require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Pardot::Authentication do
  
  def create_client
    @client = Pardot::Client.new "user@test.com", "foo", "bar"
  end
  
  describe "authenticate" do
    
    before do
      @client = create_client
      
      fake_post "/api/login/version/3?email=user%40test.com&password=foo&user_key=bar",
                %(<?xml version="1.0" encoding="UTF-8"?>\n<rsp stat="ok" version="1.0">\n   <api_key>my_api_key</api_key>\n</rsp>\n)
    end
    
    def authenticate
      @client.authenticate
    end
    
    it "should return the api key" do
      authenticate.should == "my_api_key"
    end
    
    it "should set the api key" do
      authenticate
      @client.api_key.should == "my_api_key"
    end
    
    it "should make authenticated? true" do
      authenticate
      @client.authenticated?.should == true
    end
    
  end
  
end