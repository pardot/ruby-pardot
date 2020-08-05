require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Pardot::Client do
  
  def create_client
    @client = Pardot::Client.new "user@test.com", "foo", "bar"
  end
  
  describe "client" do
    after do
      expect(@client.email).to eq("user@test.com")
      expect(@client.password).to eq("password")
      expect(@client.user_key).to eq("user_key")
      expect(@client.format).to eq("simple")
    end

    it "should set variables without version" do
      @client = Pardot::Client.new "user@test.com", "password", "user_key"
      expect(@client.version).to eq(3)
    end
    
    it "should set variables with version" do
      @client = Pardot::Client.new "user@test.com", "password", "user_key", 4
      expect(@client.version).to eq(4)
    end

  end
end
