# frozen_string_literal: true

require File.expand_path("#{File.dirname(__FILE__)}/../../spec_helper")

describe Pardot::Objects::Prospects do
  create_auth_managers.each do |auth_manager|
    context auth_manager.test_name_suffix do
      let(:client) { auth_manager.create_client }

      describe 'query' do
        def sample_results
          %(<?xml version="1.0" encoding="UTF-8"?>
          <rsp stat="ok" version="1.0">
            <result>
              <total_results>2</total_results>
              <prospect>
                <first_name>Jim</first_name>
                <last_name>Smith</last_name>
              </prospect>
              <prospect>
                <first_name>Sue</first_name>
                <last_name>Green</last_name>
              </prospect>
            </result>
          </rsp>)
        end

        it 'should take in some arguments' do
          fake_get '/api/prospect/version/3/do/query?assigned=true&format=simple', sample_results

          expect(client.prospects.query(assigned: true)).to eq({ 'total_results' => 2,
                                                                 'prospect' => [
                                                                   { 'last_name' => 'Smith', 'first_name' => 'Jim' },
                                                                   { 'last_name' => 'Green', 'first_name' => 'Sue' }
                                                                 ] })
          assert_authorization_header auth_manager
        end
      end

      describe 'create' do
        def sample_results
          %(<?xml version="1.0" encoding="UTF-8"?>
          <rsp stat="ok" version="1.0">
            <prospect>
              <first_name>Jim</first_name>
              <last_name>Smith</last_name>
            </prospect>
          </rsp>)
        end

        it 'should return the prospect' do
          fake_post '/api/prospect/version/3/do/create/email/user%40test.com?first_name=Jim&format=simple',
                    sample_results

          expect(client.prospects.create('user@test.com',
                                         first_name: 'Jim')).to eq({ 'last_name' => 'Smith', 'first_name' => 'Jim' })
          assert_authorization_header auth_manager
        end
      end
    end
  end
end
