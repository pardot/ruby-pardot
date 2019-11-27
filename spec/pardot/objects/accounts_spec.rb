require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Pardot::Objects::Accounts do
  before do
    @client = create_client
  end
  
  describe "read" do
    
    def sample_results
      %(<?xml version="1.0" encoding="UTF-8"?>\n<rsp stat="ok" version="1.0">
        <account>
          <id>123</id>
          <company>Test Company</company>
        </account>
      </rsp>)
    end
    
    before do
      @client = create_client
    end
    
    it "should read the account" do
      fake_get "/api/account/version/3/do/read?user_key=bar&api_key=my_api_key&format=simple", sample_results
      
      @client.accounts.read.should == {"id" => "123", "company" => "Test Company"}
    end
  end
end
