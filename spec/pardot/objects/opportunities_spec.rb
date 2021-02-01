# frozen_string_literal: true

require File.expand_path("#{File.dirname(__FILE__)}/../../spec_helper")

describe Pardot::Objects::Opportunities do
  create_auth_managers.each do |auth_manager|
    context auth_manager.test_name_suffix do
      let(:client) { auth_manager.create_client }

      describe 'query' do
        def sample_results
          %(<?xml version="1.0" encoding="UTF-8"?>\n<rsp stat="ok" version="1.0">
            <result>
              <total_results>2</total_results>
              <opportunity>
                <name>Jim</name>
                <type>Great</type>
              </opportunity>
              <opportunity>
                <name>Sue</name>
                <type>Good</type>
              </opportunity>
            </result>
          </rsp>)
        end

        it 'should take in some arguments' do
          fake_get '/api/opportunity/version/3/do/query?id_greater_than=200&format=simple', sample_results

          expected = {
            'total_results' => 2,
            'opportunity' => [
              { 'type' => 'Great', 'name' => 'Jim' },
              { 'type' => 'Good', 'name' => 'Sue' }
            ]
          }
          expect(client.opportunities.query(id_greater_than: 200)).to eq(expected)
          assert_authorization_header auth_manager
        end
      end

      describe 'create_by_email' do
        def sample_results
          %(<?xml version="1.0" encoding="UTF-8"?>
          <rsp stat="ok" version="1.0">
            <opportunity>
              <name>Jim</name>
              <type>Good</type>
            </opportunity>
          </rsp>)
        end

        it 'should return the prospect' do
          fake_post '/api/opportunity/version/3/do/create/prospect_email/user@test.com?type=Good&format=simple&name=Jim', sample_results

          expect(client.opportunities.create_by_email('user@test.com', name: 'Jim', type: 'Good')).to eq({ 'name' => 'Jim', 'type' => 'Good' })

          assert_authorization_header auth_manager
        end
      end
    end
  end
end
