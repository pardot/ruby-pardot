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
      fake_get "/api/prospectAccount/version/3/do/query?assigned=true&format=simple&user_key=bar&api_key=my_api_key", sample_results

      @client.prospect_accounts.query(:assigned => true).should == {'total_results' => 2,
        'prospectAccount'=>[
          {'name'=>'Spaceships R Us'},
          {'name'=>'Monsters Inc'}
        ]}
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
      fake_post '/api/prospectAccount/version/3/do/read/id/1234?assigned=true&format=simple&user_key=bar&api_key=my_api_key', sample_results

      @client.prospect_accounts.read('1234', :assigned => true).should == {'id' => '1234', 'name' => 'SupaDupaPanda' }
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
      fake_post '/api/prospectAccount/version/3/do/create?api_key=my_api_key&user_key=bar&format=simple&name=SuperPanda', sample_results

      @client.prospect_accounts.create(:name => 'SuperPanda').should == {"name"=>"SuperPanda"}

    end

  end

  describe 'assign' do
    def sample_results
      %(<?xml version="1.0" encoding="UTF-8"?>
      <rsp stat="ok" version="1.0">
        <prospectAccount>
          <id>1234</id>
          <name>SuperPanda</name>
          <assigned_to>
            <user_id>4321</user_id>
            <user_email>pandaklaus@northpole.np</user_email>
          </assigned_to>
        </prospectAccount>
      </rsp>)
    end

    it 'should return the prospect account with the assigned_to tag' do
      fake_post '/api/prospectAccount/version/3/do/assign/id/1234?api_key=my_api_key&user_key=bar&format=simple&user_id=4321', sample_results

      @client.prospect_accounts.assign('1234', {:user_id => '4321'}).should == {'id' => '1234', 'name' => 'SuperPanda', 'assigned_to' => { 'user_id' => '4321', 'user_email' => 'pandaklaus@northpole.np' }}
    end
  end

end
