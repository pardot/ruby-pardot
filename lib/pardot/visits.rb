module Pardot
  module Visits
    
    def visits
      @visits ||= Visits.new self
    end
    
    class Visits
      
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
      
      def get path, params = {}, result = "visit"
        response = @client.get "visit", path, params
        result ? response[result] : response
      end
      
      def post path, params = {}, result = "visit"
        response = @client.post "visit", path, params
        result ? response[result] : response
      end
      
    end
    
  end
end
