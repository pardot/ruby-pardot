module Pardot
  module Authentication
    
    def authenticate
      resp = post "login", nil, :email => @email, :password => @password, :user_key => @user_key
      @api_key = resp["api_key"]
    end
    
    def authenticated?
      @api_key != nil
    end
    
  end
end
