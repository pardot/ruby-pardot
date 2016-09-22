module Pardot
  module Authentication
    
    def authenticate
      resp = post "login", nil, :email => @email, :password => @password, :user_key => @user_key
      set_version(parse_version(resp["version"])) if resp && resp["version"]
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

    def parse_version version
      if version.is_a? Array
        version = version.last
      end
      if version.to_i > 3
        return version
      else
        return 3
      end
    end

  end
end
