module Pardot
  module Objects
    class BaseObject

      def initialize client
        @client = client
      end

      def query params
        result = get '/do/query', params, nil
        result['total_results'] = result['total_results'].to_i if result['total_results']
        result
      end

      protected

      def get path, params = {}, result = self.class::OBJECT_NAME
        response = @client.get self.class::OBJECT_NAME, path, params
        result ? response[result] : response
      end

      def post path, params = {}, result = self.class::OBJECT_NAME
        response = @client.post self.class::OBJECT_NAME, path, params
        result ? response[result] : response
      end
    end
  end
end