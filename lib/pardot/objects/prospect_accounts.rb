module Pardot
  module Objects
    module ProspectAccounts
      def prospect_accounts
        @prospect_accounts ||=
          ::Pardot::Objects::ProspectAccounts::ProspectAccounts.new(self)
      end

      class ProspectAccounts

        def initialize(client)
          @client = client
        end

        def query(search_criteria)
          result = get '/do/query', search_criteria, 'result'
          result['total_results'] = result['total_results'].to_i if
            result['total_results']
          result
        end

        def describe(params={})
          post('/do/describe', params)
        end

        def create(params={})
          post('/do/create', params)
        end

        def read(id, params={})
          post(api_url('read', 'id', id), params)
        end

        def update(id, params={})
          post(api_url('update', 'id', id), params)
        end

        # params must include either `user_email`,
        # `user_id`, or `group_id`
        def assign(id, params={})
          post(api_url('assign', 'id', id), params)
        end

        private

        def api_url(verb, direct_to, value)
          "/do/#{verb}/#{direct_to}/#{value}"
        end

        def get(path, params={}, result='prospectAccount')
          response = @client.get('prospectAccount', path, params)
          result ? response[result] : response
        end

        def post(path, params={}, result='prospectAccount')
          response = @client.post('prospectAccount', path, params)
          result ? response[result] : response
        end
      end
    end
  end
end
