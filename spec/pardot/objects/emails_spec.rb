require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Pardot::Objects::Emails do

  before do
    @client = create_client
  end

  def sample_response
    %(<?xml version="1.0" encoding="UTF-8"?>\n<rsp stat="ok" version="1.0">
      <email>
        <name>My Email</name>
      </email>
    </rsp>)
  end

  before do
    @client = create_client
  end

  it "should take in the email ID" do
    fake_get "/api/email/version/3/do/read/id/12?format=simple", sample_response
    @client.emails.read_by_id(12).should == {"name" => "My Email"}
    assert_authorization_header
  end

  it 'should send to a prospect' do
    fake_post '/api/email/version/3/do/send/prospect_id/42?campaign_id=765&email_template_id=86&format=simple', sample_response
    @client.emails.send_to_prospect(42, :campaign_id => 765, :email_template_id => 86).should == {"name" => "My Email"}
    assert_authorization_header
  end

  it 'should send to a list' do
    fake_post '/api/email/version/3/do/send?email_template_id=200&list_ids[]=235&campaign_id=654&format=simple', sample_response
    @client.emails.send_to_list(:email_template_id => 200, 'list_ids[]' => 235, :campaign_id => 654).should == {"name" => "My Email"}
    assert_authorization_header
  end

end