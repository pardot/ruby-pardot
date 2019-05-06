require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Pardot::Objects::ProspectAccounts do

  before do
    @client = create_client
  end

  describe "query" do

    def sample_results
      %(<?xml version="1.0" encoding="UTF-8"?>
      <rsp stat="ok" version="1.0">
        <result>
          <total_results>2</total_results>
          <prospectAccount>
            <name>Spaceships R Us</name>
          </prospectAccount>
          <prospectAccount>
            <name>Monsters Inc</name>
          </prospectAccount>
        </result>
      </rsp>)
    end

    it "should take in some arguments and respond with valid items" do
      fake_get "/api/prospectAccount/version/3/do/query?assigned=true&format=simple", sample_results

      @client.prospect_accounts.query(:assigned => true).should == {'total_results' => 2,
        'prospectAccount'=>[
          {'name'=>'Spaceships R Us'},
          {'name'=>'Monsters Inc'}
        ]}
      assert_authorization_header
    end

  end

  describe 'read' do
    def sample_results
      %(<?xml version="1.0" encoding="UTF-8"?>
      <rsp stat="ok" version="1.0">
        <prospectAccount>
          <id>1234</id>
          <name>SupaDupaPanda</name>
        </prospectAccount>
        </rsp>)
    end

    it 'should return a valid account' do
      fake_post '/api/prospectAccount/version/3/do/read/id/1234?assigned=true&format=simple', sample_results

      @client.prospect_accounts.read('1234', :assigned => true).should == {'id' => '1234', 'name' => 'SupaDupaPanda' }
      assert_authorization_header
    end

  end


  describe 'create' do

    def sample_results
      %(<?xml version="1.0" encoding="UTF-8"?>
      <rsp stat="ok" version="1.0">
        <prospectAccount>
          <name>SuperPanda</name>
        </prospectAccount>
      </rsp>)
    end

    it 'should return the prospect account' do
      fake_post '/api/prospectAccount/version/3/do/create?format=simple&name=SuperPanda', sample_results

      @client.prospect_accounts.create(:name => 'SuperPanda').should == {"name"=>"SuperPanda"}
      assert_authorization_header
    end

  end

end
