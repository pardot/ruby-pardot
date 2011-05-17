module Pardot
  module Users
    
    def users
      @users ||= Users.new self
    end
    
    class Users
      
      def initialize client
        @client = client
      end
      
      def query params
        result = get "/do/query", params, "result"
        result["total_results"] = result["total_results"].to_i if result["total_results"]
        result
      end
      
      def read_by_email email, params = {}
        post "/do/read/email/#{email}", params
      end
      
      def readby_id id, params = {}
        post "/do/read/id/#{id}", params
      end
      
      protected
      
      def get path, params = {}, result = "user"
        response = @client.get "user", path, params
        result ? response[result] : response
      end
      
      def post path, params = {}, result = "user"
        response = @client.post "user", path, params
        result ? response[result] : response
      end
      
    end
    
  end
end
