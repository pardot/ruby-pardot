module Pardot
  module Objects
    module VisitorActivities
      
      def visitor_activities
        @visitor_activities ||= VisitorActivities.new self
      end
      
      class VisitorActivities
        
        def initialize client
          @client = client
        end
        
        def query params
          result = get "/do/query", params, "result"
          result["total_results"] = result["total_results"].to_i if result["total_results"]
          result
        end
        
        def read id, params = {}
          post "/do/read/id/#{id}", params
        end
        
        protected
        
        def get path, params = {}, result = "visitorActivity"
          response = @client.get "visitorActivity", path, params
          result ? response[result] : response
        end
        
        def post path, params = {}, result = "visitorActivity"
          response = @client.post "visitorActivity", path, params
          result ? response[result] : response
        end
        
      end
      
    end
  end
end
