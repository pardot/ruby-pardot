require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Pardot::Objects::Lists do

  let!(:client) { create_client }

  describe 'query' do

    let(:response) do
      { 'total_results' => 2,
        'list'          => [{ 'name' => 'Asdf List' }, { 'name' => 'Qwerty List' }] }
    end

    it 'should take in some arguments' do
      fake_get '/api/list/version/3/do/query?api_key=my_api_key&id_greater_than=200&format=json&output=simple&user_key=bar',
               response.to_json

      client.lists.query(:id_greater_than => 200).should == response
    end
  end
end