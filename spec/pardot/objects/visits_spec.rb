require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Pardot::Objects::Visits do
  
  before do
    @client = create_client
  end
  
  describe "query" do
    
    def sample_results
      %(<?xml version="1.0" encoding="UTF-8"?>\n<rsp stat="ok" version="1.0">
        <result>
          <total_results>2</total_results>
          <visit>
            <duration_in_seconds>50</duration_in_seconds>
            <visitor_page_view_count>3</visitor_page_view_count>
          </visit>
          <visit>
            <duration_in_seconds>10</duration_in_seconds>
            <visitor_page_view_count>1</visitor_page_view_count>
          </visit>
        </result>
      </rsp>)
    end
    
    before do
      @client = create_client
    end
    
    it "should take in some arguments" do
      fake_get "/api/visit/version/3/do/query?id_greater_than=200&format=simple", sample_results
      
      @client.visits.query(:id_greater_than => 200).should == {"total_results" => 2, 
        "visit"=>[
          {"duration_in_seconds"=>"50", "visitor_page_view_count"=>"3"}, 
          {"duration_in_seconds"=>"10", "visitor_page_view_count"=>"1"}
        ]}
      assert_authorization_header
    end
    
  end
  
  describe "read" do
    
    def sample_results
      %(<?xml version="1.0" encoding="UTF-8"?>
      <rsp stat="ok" version="1.0">
        <visit>
          <duration_in_seconds>10</duration_in_seconds>
          <visitor_page_view_count>1</visitor_page_view_count>
        </visit>
      </rsp>)
    end
    
    it "should return the prospect" do
      fake_post "/api/visit/version/3/do/read/id/10?format=simple", sample_results
      
      @client.visits.read(10).should == {"visitor_page_view_count"=>"1", "duration_in_seconds"=>"10"}
      assert_authorization_header
    end
    
  end
  
end