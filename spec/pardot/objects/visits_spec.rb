# frozen_string_literal: true

require File.expand_path("#{File.dirname(__FILE__)}/../../spec_helper")

describe Pardot::Objects::Visits do
  create_auth_managers.each do |auth_manager|
    context auth_manager.test_name_suffix do
      let(:client) { auth_manager.create_client }
      describe 'query' do
        def sample_results
          %(<?xml version="1.0" encoding="UTF-8"?>\n<rsp stat="ok" version="1.0">
            <result>
              <total_results>2</total_results>
              <visit>
                <duration_in_seconds>50</duration_in_seconds>
                <visitor_page_view_count>3</visitor_page_view_count>
              </visit>
              <visit>
                <duration_in_seconds>10</duration_in_seconds>
                <visitor_page_view_count>1</visitor_page_view_count>
              </visit>
            </result>
          </rsp>)
        end

        it 'should take in some arguments' do
          fake_get '/api/visit/version/3/do/query?id_greater_than=200&format=simple', sample_results

          expect(client.visits.query(id_greater_than: 200)).to eq({ 'total_results' => 2,
                                                                    'visit' => [
                                                                      { 'duration_in_seconds' => '50',
                                                                        'visitor_page_view_count' => '3' },
                                                                      { 'duration_in_seconds' => '10',
                                                                        'visitor_page_view_count' => '1' }
                                                                    ] })
          assert_authorization_header auth_manager
        end
      end

      describe 'read' do
        def sample_results
          %(<?xml version="1.0" encoding="UTF-8"?>
          <rsp stat="ok" version="1.0">
            <visit>
              <duration_in_seconds>10</duration_in_seconds>
              <visitor_page_view_count>1</visitor_page_view_count>
            </visit>
          </rsp>)
        end

        it 'should return the prospect' do
          fake_post '/api/visit/version/3/do/read/id/10?format=simple', sample_results

          expect(client.visits.read(10)).to eq({ 'visitor_page_view_count' => '1', 'duration_in_seconds' => '10' })
          assert_authorization_header auth_manager
        end
      end
    end
  end
end
