module Pardot
  module Objects
    module Lists
      def lists
        @lists ||= Lists.new self
      end

      class Lists
        def initialize(client)
          @client = client
        end

        def create(_id, params = {})
          post '/do/create', params
        end

        def query(params)
          result = get '/do/query', params, 'result'
          result['total_results'] = result['total_results'].to_i if result['total_results']
          result
        end

        def read_by_id(id, params = {})
          get "/do/read/id/#{id}", params
        end

        def update(id, _params = {})
          post "/do/update/#{id}"
        end

        protected

        def get(path, params = {}, result = 'list')
          response = @client.get 'list', path, params
          result ? response[result] : response
        end

        def post(path, params = {}, result = 'list')
          response = @client.post 'list', path, params
          result ? response[result] : response
        end
      end
    end
  end
end
