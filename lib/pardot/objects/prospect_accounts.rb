module Pardot
  module Objects
    module ProspectAccounts
      def prospect_accounts
        @prospect_accounts ||= ProspectAccounts.new self
      end

      class ProspectAccounts

        def initialize(client)
          @client = client
        end

        def query(search_criteria)
          result = get '/do/query', search_criteria, 'result'
          result['total_results'] = result['total_results'].to_i if result['total_results']
          result
        end

        # assign_by_email
        # assign_by_id
        # read_by_email
        # read_by_id
        # update_by_email
        # update_by_id
        # upsert_by_email
        # upsert_by_id
        [:assign, :read, :update, :upsert].each do |verb|
          [:email, :id].each do |direct_to|
            define_method("#{verb}_by_#{direct_to}") do |directive_value, **params|
              post(api_url(verb, direct_to, directive_value), params)
            end
          end
        end

        def create(email, **params)
          post(api_url(:create, :email, email), params)
        end

        private

        def api_url(verb, direct_to, value)
          "/do/#{verb}/#{direct_to}/#{value}"
        end

        def get(path, params={}, result='prospect_account')
          response = @client.get('prospect_account', path, params)
          result ? response[result] : response
        end

        def post(path, params={}, result='prospect_account')
          response = @client.post('prospect_account', path, params)
          result ? response[result] : response
        end
      end
    end
  end
end
