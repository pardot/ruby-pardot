require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Pardot::Objects::Users do
  
  before do
    @client = create_client
  end
  
  describe "query" do
    
    def sample_results
      %(<?xml version="1.0" encoding="UTF-8"?>\n<rsp stat="ok" version="1.0">
        <result>
          <total_results>2</total_results>
          <user>
            <email>user@test.com</email>
            <first_name>Jim</first_name>
          </user>
          <user>
            <email>user@example.com</email>
            <first_name>Sue</first_name>
          </user>
        </result>
      </rsp>)
    end
    
    before do
      @client = create_client
    end
    
    it "should take in some arguments" do
      fake_get "/api/user/version/3/do/query?id_greater_than=200&format=simple", sample_results
      
      @client.users.query(:id_greater_than => 200).should == {"total_results" => 2, 
        "user"=>[
          {"email"=>"user@test.com", "first_name"=>"Jim"}, 
          {"email"=>"user@example.com", "first_name"=>"Sue"}
        ]}
      assert_authorization_header
    end
    
  end
  
  describe "read_by_email" do
    
    def sample_results
      %(<?xml version="1.0" encoding="UTF-8"?>
      <rsp stat="ok" version="1.0">
        <user>
          <email>user@example.com</email>
          <first_name>Sue</first_name>
        </user>
      </rsp>)
    end
    
    it "should return the prospect" do
      fake_post "/api/user/version/3/do/read/email/user@test.com?format=simple", sample_results
      
      @client.users.read_by_email("user@test.com").should == {"email"=>"user@example.com", "first_name"=>"Sue"}
      assert_authorization_header
    end
    
  end
  
end