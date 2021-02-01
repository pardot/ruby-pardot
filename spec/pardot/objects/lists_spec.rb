# frozen_string_literal: true

require File.expand_path("#{File.dirname(__FILE__)}/../../spec_helper")

describe Pardot::Objects::Lists do
  create_auth_managers.each do |auth_manager|
    context auth_manager.test_name_suffix do
      let(:client) { auth_manager.create_client }

      describe 'query' do
        def sample_results
          %(<?xml version="1.0" encoding="UTF-8"?>\n<rsp stat="ok" version="1.0">
            <result>
              <total_results>2</total_results>
              <list>
                <name>Asdf List</name>
              </list>
              <list>
                <name>Qwerty List</name>
              </list>
            </result>
          </rsp>)
        end

        it 'should take in some arguments' do
          fake_get '/api/list/version/3/do/query?id_greater_than=200&format=simple', sample_results

          expect(client.lists.query(id_greater_than: 200)).to eq({ 'total_results' => 2,
                                                                   'list' => [
                                                                     { 'name' => 'Asdf List' },
                                                                     { 'name' => 'Qwerty List' }
                                                                   ] })
          assert_authorization_header auth_manager
        end
      end
    end
  end
end
