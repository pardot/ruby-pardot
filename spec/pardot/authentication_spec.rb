require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Pardot::Authentication do
  
  def create_client
    @client = Pardot::Client.new "user@test.com", "foo", "bar"
  end
  
  describe "authenticate" do
    
    before do
      @client = create_client
      
      fake_post "/api/login/version/3",
                %(<?xml version="1.0" encoding="UTF-8"?>\n<rsp stat="ok" version="1.0">\n   <api_key>my_api_key</api_key>\n</rsp>\n)
    end
    
    def authenticate
      @client.authenticate
    end

    def verifyBody
      FakeWeb.last_request.body.should == 'email=user%40test.com&password=foo&user_key=bar'
    end
    
    it "should return the api key" do
      authenticate.should == "my_api_key"
    end
    
    it "should set the api key" do
      authenticate
      @client.api_key.should == "my_api_key"
      verifyBody
    end
    
    it "should make authenticated? true" do
      authenticate
      @client.authenticated?.should == true
      verifyBody
    end

    it "should use version 3" do
      authenticate
      @client.version.to_i.should == 3
      verifyBody
    end
    
  end

  describe "authenticateV4" do
    
    before do
      @client = create_client
      
      fake_post "/api/login/version/3",
                %(<?xml version="1.0" encoding="UTF-8"?>\n<rsp stat="ok" version="1.0">\n   <api_key>my_api_key</api_key>\n<version>4</version>\n</rsp>\n)
    end
    
    def authenticate
      @client.authenticate
    end

    def verifyBody
      FakeWeb.last_request.body.should == 'email=user%40test.com&password=foo&user_key=bar'
    end
    
    it "should return the api key" do
      authenticate.should == "my_api_key"
    end
    
    it "should set the api key" do
      authenticate
      @client.api_key.should == "my_api_key"
      verifyBody
    end
    
    it "should make authenticated? true" do
      authenticate
      @client.authenticated?.should == true
      verifyBody
    end

    it "should use version 4" do
      authenticate
      @client.version.to_i.should == 4
      verifyBody
    end
    
  end
  
end