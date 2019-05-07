require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Pardot::Objects::Opportunities do
  
  before do
    @client = create_client
  end
  
  describe "query" do
    
    def sample_results
      %(<?xml version="1.0" encoding="UTF-8"?>\n<rsp stat="ok" version="1.0">
        <result>
          <total_results>2</total_results>
          <opportunity>
            <name>Jim</name>
            <type>Great</type>
          </opportunity>
          <opportunity>
            <name>Sue</name>
            <type>Good</type>
          </opportunity>
        </result>
      </rsp>)
    end
    
    before do
      @client = create_client
    end
    
    it "should take in some arguments" do
      fake_get "/api/opportunity/version/3/do/query?id_greater_than=200&format=simple", sample_results
      
      @client.opportunities.query(:id_greater_than => 200).should == {"total_results" => 2, 
        "opportunity"=>[
          {"type"=>"Great", "name"=>"Jim"}, 
          {"type"=>"Good", "name"=>"Sue"}
        ]}
      assert_authorization_header
    end
    
  end
  
  describe "create_by_email" do
    
    def sample_results
      %(<?xml version="1.0" encoding="UTF-8"?>
      <rsp stat="ok" version="1.0">
        <opportunity>
          <name>Jim</name>
          <type>Good</type>
        </opportunity>
      </rsp>)
    end
    
    it "should return the prospect" do
      fake_post "/api/opportunity/version/3/do/create/prospect_email/user@test.com?type=Good&format=simple&name=Jim", sample_results
      
      @client.opportunities.create_by_email("user@test.com", :name => "Jim", :type => "Good").should == {"name"=>"Jim", "type"=>"Good"}

      assert_authorization_header
    end
    
  end
  
end