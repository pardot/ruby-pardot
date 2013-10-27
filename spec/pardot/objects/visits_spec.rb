require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Pardot::Objects::Visits do

  let!(:client) { create_client }
  
  describe 'query' do
    let (:response) do
      { 'total_results' => 2,
        'visit'          =>
            [{ 'duration_in_seconds' => '50', 'visitor_page_view_count' => '3' },
             { 'duration_in_seconds' => '10', 'visitor_page_view_count' => '1' }] }
    end

    it 'should take in some arguments' do
      fake_get '/api/visit/version/3/do/query?api_key=my_api_key&user_key=bar&id_greater_than=200&format=json&output=simple',
               response.to_json
      
      client.visits.query(:id_greater_than => 200).should == response
    end
    
  end
  
  describe 'read' do
    
    let (:response) do
      {'visit' => { 'duration_in_seconds' => '10', 'visitor_page_view_count' => '1' } }
    end
    
    it 'should return the prospect' do
      fake_post '/api/visit/version/3/do/read/id/10', response.to_json
      
      client.visits.read(10).should == response['visit']
      
    end
    
  end
  
end