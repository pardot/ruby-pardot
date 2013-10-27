require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Pardot::Objects::Emails do

  let!(:client) { create_client }

  let(:response) do
    { 'email' => {
        'id' => 1,
        'name' => 'Test',
        'subject' => 'Testing',
        'message' => { 'text' => 'Content!',
                       'html' => '<html><body><p>Content!</p></body></html>' } } }
  end

  describe 'read' do
    it 'find an email by id' do
      fake_get '/api/email/version/3/do/read/id/1?user_key=bar&api_key=my_api_key&format=json&output=simple',
               response.to_json

      client.emails.read_by_id(1).should == response['email']
    end
  end
  
  describe 'send' do
    it 'should send an email to a prospect by id' do
      fake_post '/api/email/version/3/do/send/prospect_id/10', response.to_json
      
      client.emails.send_by_id(10).should == response['email']
    end

    it 'should send an email to a prospect by email' do
      fake_post '/api/email/version/3/do/send/prospect_email/fake@email.com', response.to_json

      client.emails.send_by_email('fake@email.com').should == response['email']
    end

    it 'should send an email to a list' do
      fake_post '/api/email/version/3/do/send', response.to_json

      client.emails.send_to_lists(10, [5, 6, 7], :email_template_id => 5).should == response['email']
    end
  end
end