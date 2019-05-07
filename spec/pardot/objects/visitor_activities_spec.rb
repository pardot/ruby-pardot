require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Pardot::Objects::VisitorActivities do
  
  before do
    @client = create_client
  end
  
  describe "query" do
    
    def sample_results
      %(<?xml version="1.0" encoding="UTF-8"?>\n<rsp stat="ok" version="1.0">
        <result>
          <total_results>2</total_results>
          <visitorActivity>
            <type_name>Read</type_name>
            <details>Some details</details>
          </visitorActivity>
          <visitorActivity>
            <type_name>Write</type_name>
            <details>More details</details>
          </visitorActivity>
        </result>
      </rsp>)
    end
    
    before do
      @client = create_client
    end
    
    it "should take in some arguments" do
      fake_get "/api/visitorActivity/version/3/do/query?id_greater_than=200&format=simple", sample_results
      
      @client.visitor_activities.query(:id_greater_than => 200).should == {"total_results" => 2, 
        "visitorActivity"=>[
          {"type_name"=>"Read", "details"=>"Some details"}, 
          {"type_name"=>"Write", "details"=>"More details"}
        ]}
      assert_authorization_header
    end
    
  end
  
  describe "read" do
    
    def sample_results
      %(<?xml version="1.0" encoding="UTF-8"?>
      <rsp stat="ok" version="1.0">
        <visitorActivity>
          <type_name>Write</type_name>
          <details>More details</details>
        </visitorActivity>
      </rsp>)
    end
    
    it "should return the prospect" do
      fake_post "/api/visitorActivity/version/3/do/read/id/10?format=simple", sample_results
      
      @client.visitor_activities.read(10).should == {"details"=>"More details", "type_name"=>"Write"}
      assert_authorization_header
    end
    
  end
  
end