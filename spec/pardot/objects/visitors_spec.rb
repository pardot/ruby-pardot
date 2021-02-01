# frozen_string_literal: true

require File.expand_path("#{File.dirname(__FILE__)}/../../spec_helper")

describe Pardot::Objects::Visitors do
  create_auth_managers.each do |auth_manager|
    context auth_manager.test_name_suffix do
      let(:client) { auth_manager.create_client }
      describe 'query' do
        def sample_results
          %(<?xml version="1.0" encoding="UTF-8"?>\n<rsp stat="ok" version="1.0">
            <result>
              <total_results>2</total_results>
              <visitor>
                <browser>Firefox</browser>
                <language>en</language>
              </visitor>
              <visitor>
                <browser>Chrome</browser>
                <language>es</language>
              </visitor>
            </result>
          </rsp>)
        end

        it 'should take in some arguments' do
          fake_get '/api/visitor/version/3/do/query?id_greater_than=200&format=simple', sample_results

          expect(client.visitors.query(id_greater_than: 200)).to eq({ 'total_results' => 2,
                                                                      'visitor' => [
                                                                        { 'browser' => 'Firefox',
                                                                          'language' => 'en' },
                                                                        { 'browser' => 'Chrome', 'language' => 'es' }
                                                                      ] })
          assert_authorization_header auth_manager
        end
      end

      describe 'assign' do
        def sample_results
          %(<?xml version="1.0" encoding="UTF-8"?>
          <rsp stat="ok" version="1.0">
            <visitor>
              <browser>Chrome</browser>
              <language>es</language>
            </visitor>
          </rsp>)
        end

        it 'should return the prospect' do
          fake_post '/api/visitor/version/3/do/assign/id/10?type=Good&format=simple&name=Jim', sample_results

          expect(client.visitors.assign(10, name: 'Jim',
                                            type: 'Good')).to eq({ 'browser' => 'Chrome', 'language' => 'es' })
          assert_authorization_header auth_manager
        end
      end
    end
  end
end
