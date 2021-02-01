# frozen_string_literal: true

require File.expand_path("#{File.dirname(__FILE__)}/../../spec_helper")

describe Pardot::Objects::Emails do
  create_auth_managers.each do |auth_manager|
    context auth_manager.test_name_suffix do
      let(:client) { auth_manager.create_client }

      def sample_response
        %(<?xml version="1.0" encoding="UTF-8"?>\n<rsp stat="ok" version="1.0">
          <email>
            <name>My Email</name>
          </email>
        </rsp>)
      end

      it 'should take in the email ID' do
        fake_get '/api/email/version/3/do/read/id/12?format=simple', sample_response
        expect(client.emails.read_by_id(12)).to eq({ 'name' => 'My Email' })
        assert_authorization_header auth_manager
      end

      it 'should send to a prospect' do
        fake_post '/api/email/version/3/do/send/prospect_id/42?campaign_id=765&email_template_id=86&format=simple', sample_response
        expect(client.emails.send_to_prospect(42, campaign_id: 765, email_template_id: 86)).to eq({ 'name' => 'My Email' })
        assert_authorization_header auth_manager
      end

      it 'should send to a list' do
        fake_post '/api/email/version/3/do/send?email_template_id=200&list_ids%5B%5D=235&campaign_id=654&format=simple', sample_response
        expect(client.emails.send_to_list(:email_template_id => 200, 'list_ids[]' => 235, :campaign_id => 654)).to eq({ 'name' => 'My Email' })
        assert_authorization_header auth_manager
      end
    end
  end
end
