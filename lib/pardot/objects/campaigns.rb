module Pardot
  module Objects
    module Campaigns
      def campaigns
        @campaigns ||= Campaigns.new self
      end

      class Campaigns

        def initialize(client)
          @client = client
        end

        def query(search_criteria)
          result = get('/do/query', search_criteria, 'result')
          result['total_results'] = result['total_results'].to_i if result['total_results']
          result
        end

        def create(params={})
          post('/do/create', params)
        end

        # read_by_id
        # update_by_id
        [:read, :update].each do |verb|
          define_method(verb) do |id, params ={}|
            post(api_url(verb, 'id', id), params)
          end
        end

        private

        def api_url(verb, direct_to, value)
          "/do/#{verb}/#{direct_to}/#{value}"
        end

        def get(path, params={}, result='campaign')
          response = @client.get('campaign', path, params)
          result ? response[result] : response
        end

        def post(path, params={}, result='campaign')
          response = @client.post('campaign', path, params)
          result ? response[result] : response
        end
      end
    end
  end
end
