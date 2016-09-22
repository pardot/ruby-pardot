require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Pardot::Client do
  
  def create_client
    @client = Pardot::Client.new "user@test.com", "foo", "bar"
  end
  
  describe "client" do
    after do
      @client.email.should == "user@test.com"
      @client.password.should == "password"
      @client.user_key.should == "user_key"
      @client.format.should == "simple"
    end

    it "should set variables without version" do
      @client = Pardot::Client.new "user@test.com", "password", "user_key"
      @client.version.should == 3
    end
    
    it "should set variables with version" do
      @client = Pardot::Client.new "user@test.com", "password", "user_key", 4
      @client.version.should == 4
    end

  end
end
