# frozen_string_literal: true

require File.expand_path("#{File.dirname(__FILE__)}/../../spec_helper")

describe Pardot::Objects::Users do
  create_auth_managers.each do |auth_manager|
    context auth_manager.test_name_suffix do
      let(:client) { auth_manager.create_client }

      describe 'query' do
        def sample_results
          %(<?xml version="1.0" encoding="UTF-8"?>\n<rsp stat="ok" version="1.0">
            <result>
              <total_results>2</total_results>
              <user>
                <email>user@test.com</email>
                <first_name>Jim</first_name>
              </user>
              <user>
                <email>user@example.com</email>
                <first_name>Sue</first_name>
              </user>
            </result>
          </rsp>)
        end

        it 'should take in some arguments' do
          fake_get '/api/user/version/3/do/query?id_greater_than=200&format=simple', sample_results

          expect(client.users.query(id_greater_than: 200)).to eq({ 'total_results' => 2,
                                                                   'user' => [
                                                                     { 'email' => 'user@test.com',
                                                                       'first_name' => 'Jim' },
                                                                     { 'email' => 'user@example.com',
                                                                       'first_name' => 'Sue' }
                                                                   ] })
          assert_authorization_header auth_manager
        end
      end

      describe 'read_by_email' do
        def sample_results
          %(<?xml version="1.0" encoding="UTF-8"?>
          <rsp stat="ok" version="1.0">
            <user>
              <email>user@example.com</email>
              <first_name>Sue</first_name>
            </user>
          </rsp>)
        end

        it 'should return the prospect' do
          fake_post '/api/user/version/3/do/read/email/user@test.com?format=simple', sample_results

          expect(client.users.read_by_email('user@test.com')).to eq({ 'email' => 'user@example.com',
                                                                      'first_name' => 'Sue' })
          assert_authorization_header auth_manager
        end
      end
    end
  end
end
