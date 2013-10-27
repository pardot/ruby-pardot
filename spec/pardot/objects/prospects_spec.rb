require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Pardot::Objects::Prospects do

  let!(:client) { create_client }

  describe 'query' do

    let(:response) do
      { 'total_results' => 2,
        'prospect'      =>
            [{ 'first_name' => 'Jim',
               'last_name'  => 'Smith' },
             { 'first_name' => 'Sue',
               'last_name'  => 'Green' }] }
    end

    it 'should take in some arguments' do
      fake_get '/api/prospect/version/3/do/query?api_key=my_api_key&assigned=true&format=json&output=simple&user_key=bar',
               response.to_json

      client.prospects.query(:assigned => true).should == response
    end

  end

  describe 'create' do

    let(:response) do
      { 'prospect' => { 'first_name' => 'Jim', 'last_name' => 'Smith' } }
    end

    it 'should return the prospect' do
      fake_post '/api/prospect/version/3/do/create/email/user@test.com', response.to_json

      client.prospects.create('user@test.com', :first_name => 'Jim').should == response['prospect']
    end

  end

end