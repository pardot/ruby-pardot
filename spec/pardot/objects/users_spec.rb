require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Pardot::Objects::Users do

  let!(:client) { create_client }

  describe 'query' do

    let(:response) do
      { 'total_results' => 2,
        'user'          =>
            [{ 'email' => 'user@test.com', 'first_name' => 'Jim' },
             { 'email' => 'user@example.com', 'first_name' => 'Sue' }] }
    end

    it 'should take in some arguments' do
      fake_get '/api/user/version/3/do/query?api_key=my_api_key&user_key=bar&id_greater_than=200&format=json&output=simple',
               response.to_json

      client.users.query(:id_greater_than => 200).should == response
    end

  end

  describe 'read_by_email' do

    let(:response) do
      { 'user' => { 'email' => 'user@test.com', 'first_name' => 'Jim' } }
    end

    it 'should return the prospect' do
      fake_post '/api/user/version/3/do/read/email/user@test.com', response.to_json

      client.users.read_by_email('user@test.com').should == response['user']
    end
  end
end