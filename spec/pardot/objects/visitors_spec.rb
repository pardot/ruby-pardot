require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Pardot::Objects::Visitors do
  
  before do
    @client = create_client
  end
  
  describe "query" do
    
    def sample_results
      %(<?xml version="1.0" encoding="UTF-8"?>\n<rsp stat="ok" version="1.0">
        <result>
          <total_results>2</total_results>
          <visitor>
            <browser>Firefox</browser>
            <language>en</language>
          </visitor>
          <visitor>
            <browser>Chrome</browser>
            <language>es</language>
          </visitor>
        </result>
      </rsp>)
    end
    
    before do
      @client = create_client
    end
    
    it "should take in some arguments" do
      fake_get "/api/visitor/version/3/do/query?id_greater_than=200&format=simple", sample_results
      
      @client.visitors.query(:id_greater_than => 200).should == {"total_results" => 2, 
        "visitor"=>[
          {"browser"=>"Firefox", "language"=>"en"}, 
          {"browser"=>"Chrome", "language"=>"es"}
        ]}
      assert_authorization_header
    end
    
  end
  
  describe "assign" do
    
    def sample_results
      %(<?xml version="1.0" encoding="UTF-8"?>
      <rsp stat="ok" version="1.0">
        <visitor>
          <browser>Chrome</browser>
          <language>es</language>
        </visitor>
      </rsp>)
    end
    
    it "should return the prospect" do
      fake_post "/api/visitor/version/3/do/assign/id/10?type=Good&format=simple&name=Jim", sample_results
      
      @client.visitors.assign(10, :name => "Jim", :type => "Good").should == {"browser"=>"Chrome", "language"=>"es"}
      assert_authorization_header
    end
    
  end
  
end