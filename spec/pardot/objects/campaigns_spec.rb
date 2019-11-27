require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Pardot::Objects::Campaigns do
  before do
    @client = create_client
  end
  
  describe "query" do
    
    def sample_results
      %(<?xml version="1.0" encoding="UTF-8"?>\n<rsp stat="ok" version="1.0">
        <result>
          <total_results>2</total_results>
          <campaign>
            <id>123</id>
            <name>First Campaign</name>
            <cost>5</cost>
          </campaign>
          <campaign>
            <id>321</id>
            <name>Second Campaign</name>
            <cost>0</cost>
          </campaign>
        </result>
      </rsp>)
    end
    
    before do
      @client = create_client
    end
    
    it "should query the campaigns" do
      fake_get "/api/campaign/version/3/do/query?id_less_than=555&user_key=bar&api_key=my_api_key&format=simple", sample_results
      
      @client.campaigns.query({"id_less_than" => "555"}).should == {"total_results"=>2,
        "campaign"=>[
          {"id"=>"123", "name"=>"First Campaign", "cost"=>"5"},
          {"id"=>"321", "name"=>"Second Campaign", "cost"=>"0"}
        ]}
    end
  end
  
  describe "create" do
    
    def sample_results
      %(<?xml version="1.0" encoding="UTF-8"?>\n<rsp stat="ok" version="1.0">
        <campaign>
          <id>123</id>
          <name>New Campaign</name>
          <cost>5</cost>
        </campaign>
      </rsp>)
    end
    
    before do
      @client = create_client
    end
    
    it "should create the campaign" do
      fake_post "/api/campaign/version/3/do/create?name=New%20Campaign&cost=5&user_key=bar&api_key=my_api_key&format=simple", sample_results
      
      @client.campaigns.create({"name" => "New Campaign", "cost" => "5"}).should == {"id" => "123", "name" => "New Campaign", "cost" => "5"}
    end
  end
  
  describe "read" do
    
    def sample_results
      %(<?xml version="1.0" encoding="UTF-8"?>\n<rsp stat="ok" version="1.0">
        <campaign>
          <id>123</id>
          <name>Test Campaign</name>
          <cost>0</cost>
        </campaign>
      </rsp>)
    end
    
    before do
      @client = create_client
    end
    
    it "should read the campaign by id" do
      fake_post "/api/campaign/version/3/do/read/id/123?user_key=bar&api_key=my_api_key&format=simple", sample_results
      
      @client.campaigns.read(123).should == {"id" => "123", "name" => "Test Campaign", "cost" => "0"}
    end
  end
  
  describe "update" do
    
    def sample_results
      %(<?xml version="1.0" encoding="UTF-8"?>\n<rsp stat="ok" version="1.0">
        <campaign>
          <id>123</id>
          <name>Test Campaign Updated</name>
          <cost>0</cost>
        </campaign>
      </rsp>)
    end
    
    before do
      @client = create_client
    end
    
    it "should update the campaign by id" do
      fake_post "/api/campaign/version/3/do/update/id/123?name=Test%20Campaign%20Updated&user_key=bar&api_key=my_api_key&format=simple", sample_results
      
      @client.campaigns.update(123, {"name" => "Test Campaign Updated"}).should == {"id" => "123", "name" => "Test Campaign Updated", "cost" => "0"}
    end
  end
end
