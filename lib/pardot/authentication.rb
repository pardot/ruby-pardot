module Pardot
  module Authentication
    
    def authenticate
      resp = post "login", nil, nil, nil, :email => @email, :password => @password, :user_key => @user_key
      update_version(resp["version"]) if resp && resp["version"]
      @api_key = resp && resp["api_key"]
    end
    
    def authenticated?
      @api_key != nil
    end
    
    def reauthenticate
      @api_key = nil
      authenticate
    end

    private

    def update_version version
      if version.is_a? Array
        version = version.last
      end
      @version = version if version.to_i > 3
    end

  end
end
