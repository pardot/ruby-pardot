require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Pardot::Objects::Prospects do
  
  before do
    @client = create_client
  end
  
  describe "query" do
    
    def sample_results
      %(<?xml version="1.0" encoding="UTF-8"?>
      <rsp stat="ok" version="1.0">
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
    
    it "should take in some arguments" do
      fake_get "/api/prospect/version/3/do/query?assigned=true&format=simple&user_key=bar&api_key=my_api_key", sample_results
      
      @client.prospects.query(:assigned => true).should == {"total_results" => 2, 
        "prospect"=>[
          {"last_name"=>"Smith", "first_name"=>"Jim"}, 
          {"last_name"=>"Green", "first_name"=>"Sue"}
        ]}
    end
    
  end
  
  describe "create" do
    
    def sample_results
      %(<?xml version="1.0" encoding="UTF-8"?>
      <rsp stat="ok" version="1.0">
        <prospect>
          <first_name>Jim</first_name>
          <last_name>Smith</last_name>
        </prospect>
      </rsp>)
    end
    
    it "should return the prospect" do
      fake_post "/api/prospect/version/3/do/create/email/user@test.com?api_key=my_api_key&user_key=bar&format=simple&first_name=Jim", sample_results
      
      @client.prospects.create("user@test.com", :first_name => "Jim").should == {"last_name"=>"Smith", "first_name"=>"Jim"}
      
    end
    
  end

  context 'for API version 4:' do
    before { @client.version = 4 }

    describe 'batch_create' do
      let(:sample_response) do
        <<-RESPONSE
<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<rsp stat=\"ok\" version=\"1.0\">
  <errors/>
</rsp>
        RESPONSE
      end

      let(:endpoint) do
        '/api/prospect/version/4/do/batchCreate?prospects=%7B%22prospects%22%3A%5B%7B%22email%22%3A%22user%40test.com'\
        '%22%2C%22first_name%22%3A%22Jim%22%7D%5D%7D&user_key=bar&api_key=my_api_key&format=simple'
      end

      it 'should call proper endpoint' do
        fake_post endpoint, sample_response

        @client.prospects.batch_create([{ :email => 'user@test.com', :first_name => 'Jim' }])
      end
    end

    describe 'batch_update' do
      let(:sample_response) do
        <<-RESPONSE
<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<rsp stat=\"ok\" version=\"1.0\">
  <errors/>
</rsp>
        RESPONSE
      end

      let(:endpoint) do
        '/api/prospect/version/4/do/batchUpdate?prospects=%7B%22prospects%22%3A%7B%22123%22%3A%7B%22'\
        'first_name%22%3A%22Jim%22%7D%7D%7D&user_key=bar&api_key=my_api_key&format=simple'
      end

      it 'should call proper endpoint' do
        fake_post endpoint, sample_response

        @client.prospects.batch_update({ '123' => { :first_name => 'Jim' }})
      end
    end

    describe 'batch_upsert' do
      let(:sample_response) do
        <<-RESPONSE
<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<rsp stat=\"ok\" version=\"1.0\">
  <errors/>
</rsp>
        RESPONSE
      end

      let(:endpoint) do
        '/api/prospect/version/4/do/batchUpsert?prospects=%7B%22prospects%22%3A%5B%7B%22email%22%3A%22'\
        'user%40test.com%22%2C%22first_name%22%3A%22Jim%22%7D%5D%7D&user_key=bar&api_key=my_api_key&format=simple'
      end

      it 'should call proper endpoint' do
        fake_post endpoint, sample_response

        @client.prospects.batch_upsert([{ :email => 'user@test.com', :first_name => 'Jim' }])
      end
    end
  end
end
