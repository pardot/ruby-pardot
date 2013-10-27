require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Pardot::Objects::Visitors do

  let!(:client) { create_client }
  
  describe 'query' do

    let(:response) do
      { 'total_results' => 2,
        'visitor'          =>
            [{ 'browser' => 'Firefox', 'language' => 'en' },
             { 'browser' => 'Chrome', 'language' => 'es' }] }
    end
    
    it 'should take in some arguments' do
      fake_get '/api/visitor/version/3/do/query?api_key=my_api_key&user_key=bar&id_greater_than=200&format=json&output=simple',
               response.to_json

      client.visitors.query(:id_greater_than => 200).should == response
    end
  end
  
  describe 'assign' do

    let(:response) do
      { 'visitor' => { 'browser' => 'Chrome', 'language' => 'es' } }
    end
    
    it 'should return the prospect' do
      fake_post '/api/visitor/version/3/do/assign/id/10', response.to_json
      
      client.visitors.assign(10, :name => 'Jim', :type => 'Good').should == response['visitor']
    end
  end
end