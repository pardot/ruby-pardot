require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Pardot::Objects::Opportunities do

  let!(:client) { create_client }

  describe 'query' do

    let(:response) do
      { 'total_results' => 2,
        'opportunity'   =>
            [{ 'name' => 'Jim',
               'type' => 'Great' },
             { 'name' => 'Sue',
               'type' => 'Good' }] }
    end

    it 'should take in some arguments' do
      fake_get '/api/opportunity/version/3/do/query?api_key=my_api_key&id_greater_than=200&format=json&output=simple&user_key=bar',
               response.to_json

      client.opportunities.query(:id_greater_than => 200).should == response
    end

  end

  describe 'create_by_email' do

    let(:response) do
      { 'opportunity' =>
            { 'name' => 'Jim',
              'type' => 'Good' } }
    end

    it 'should return the prospect' do
      fake_post '/api/opportunity/version/3/do/create/prospect_email/user@test.com', response.to_json

      client.opportunities.create_by_email('user@test.com', :name => 'Jim', :type => 'Good').should == response['opportunity']
    end
  end
end