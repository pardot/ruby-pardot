module Pardot
  module Objects
    module CustomFields
      def custom_fields
        @custom_fields ||= CustomFields.new self
      end

      class CustomFields
        def initialize(client)
          @client = client
        end

        def query(params)
          result = get '/do/query', params, 'result'
          result['total_results'] = result['total_results'].to_i if result['total_results']
          result
        end

        protected

        def get(path, params = {}, result = 'customField')
          response = @client.get 'customField', path, params
          result ? response[result] : response
        end

        def post(path, params = {}, result = 'user')
          response = @client.post 'customField', path, params
          result ? response[result] : response
        end
      end
    end
  end
end
