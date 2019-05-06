require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Pardot::Objects::Lists do
  
  before do
    @client = create_client
  end
  
  describe "query" do
    
    def sample_results
      %(<?xml version="1.0" encoding="UTF-8"?>\n<rsp stat="ok" version="1.0">
        <result>
          <total_results>2</total_results>
          <list>
            <name>Asdf List</name>
          </list>
          <list>
            <name>Qwerty List</name>
          </list>
        </result>
      </rsp>)
    end
    
    before do
      @client = create_client
    end
    
    it "should take in some arguments" do
      fake_get "/api/list/version/3/do/query?id_greater_than=200&format=simple", sample_results
      
      @client.lists.query(:id_greater_than => 200).should == {"total_results" => 2, 
        "list"=>[
          {"name"=>"Asdf List"}, 
          {"name"=>"Qwerty List"}
        ]}
      assert_authorization_header
    end
    
  end
  
end