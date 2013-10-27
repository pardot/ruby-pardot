require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Pardot::Objects::VisitorActivities do

  let!(:client) { create_client }

  describe 'query' do

    let(:response) do
      { 'total_results' => 2,
        'visitorActivity'          =>
            [{ 'type_name' => 'Read', 'details' => 'Some details' },
             { 'type_name' => 'Write', 'detail' => 'More details' }] }
    end
    
    it 'should take in some arguments' do
      fake_get '/api/visitorActivity/version/3/do/query?user_key=bar&api_key=my_api_key&id_greater_than=200&format=json&output=simple',
               response.to_json
      
      client.visitor_activities.query(:id_greater_than => 200).should == response
    end
  end
  
  describe 'read' do

    let(:response) do
      {  'visitorActivity' => { 'type_name' => 'Write', 'details' => 'More details' } }
    end
    
    it 'should return the prospect' do
      fake_post '/api/visitorActivity/version/3/do/read/id/10',
                response.to_json
      
      client.visitor_activities.read(10).should == response['visitorActivity']
    end
  end
end