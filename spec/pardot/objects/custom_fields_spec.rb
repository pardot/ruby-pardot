# frozen_string_literal: true

require File.expand_path("#{File.dirname(__FILE__)}/../../spec_helper")

describe Pardot::Objects::CustomFields do
  create_auth_managers.each do |auth_manager|
    context auth_manager.test_name_suffix do
      let(:client) { auth_manager.create_client }

      describe 'query' do
        def sample_results
          %(<?xml version="1.0" encoding="UTF-8"?>\n<rsp stat="ok" version="1.0">
            <result>
              <total_results>1</total_results>
                <customField>
                  <created_at>2019-11-26 13:40:37</created_at>
                  <crm_id null="true" />
                  <field_id>CustomObject1574793618883</field_id>
                  <id>8932</id>
                  <is_record_multiple_responses>false</is_record_multiple_responses>
                  <is_use_values>false</is_use_values>
                  <name>Ω≈ç√∫˜µ≤≥÷</name>
                  <type>Text</type>
                  <type_id>1</type_id>
                  <updated_at>2019-11-26 13:40:37</updated_at>
              </customField>
            </result>
          </rsp>)
        end

        it 'should take in some arguments' do
          fake_get '/api/customField/version/3/do/query?id_greater_than=200&format=simple', sample_results

          expect(client.custom_fields.query(id_greater_than: 200)).to eq({ 'total_results' => 1,
                                                                           'customField' =>
              {
                'id' => '8932',
                'name' => 'Ω≈ç√∫˜µ≤≥÷',
                'field_id' => 'CustomObject1574793618883',
                'type' => 'Text',
                'type_id' => '1',
                'crm_id' => { 'null' => 'true' },
                'is_record_multiple_responses' => 'false',
                'is_use_values' => 'false',
                'created_at' => '2019-11-26 13:40:37',
                'updated_at' => '2019-11-26 13:40:37'
              } })
          assert_authorization_header auth_manager
        end
      end
    end
  end
end
