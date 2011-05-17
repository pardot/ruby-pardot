module Pardot
  module Objects
    module Visitors
      
      def visitors
        @visitors ||= Visitors.new self
      end
      
      class Visitors
        
        def initialize client
          @client = client
        end
        
        def query params
          result = get "/do/query", params, "result"
          result["total_results"] = result["total_results"].to_i if result["total_results"]
          result
        end
        
        def assign id, params = {}
          post "/do/assign/id/#{id}", params
        end
        
        def read id, params = {}
          post "/do/read/id/#{id}", params
        end
        
        protected
        
        def get path, params = {}, result = "visitor"
          response = @client.get "visitor", path, params
          result ? response[result] : response
        end
        
        def post path, params = {}, result = "visitor"
          response = @client.post "visitor", path, params
          result ? response[result] : response
        end
        
      end
      
    end
  end
end
