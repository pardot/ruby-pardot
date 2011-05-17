require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Pardot::Prospects do
  
  def create_client
    @client = Pardot::Client.new "user@test.com", "foo", "bar"
    @client.api_key = "my_api_key"
    @client
  end
  
  describe "query" do
    
    def sample_results
      %(<?xml version="1.0" encoding="UTF-8"?>\n<rsp stat="ok" version="1.0">
        <result>
          <total_results>2</total_results>
          <prospect>
            <first_name>Jim</first_name>
            <last_name>Smith</last_name>
          </prospect>
          <prospect>
            <first_name>Sue</first_name>
            <last_name>Green</last_name>
          </prospect>
        </result>
      </rsp>)
    end
    
    before do
      @client = create_client
    end
    
    it "should take in some arguments" do
      fake_get "/api/prospect/version/3/do/query?assigned=true&format=simple&user_key=bar&api_key=my_api_key", sample_results
      
      @client.prospects.query(:assigned => true).should == {"total_results" => 2, 
        "prospect"=>[
          {"last_name"=>"Smith", "first_name"=>"Jim"}, 
          {"last_name"=>"Green", "first_name"=>"Sue"}
        ]}
    end
    
  end
  
end