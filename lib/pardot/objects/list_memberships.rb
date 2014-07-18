module Pardot
  module Objects
    module ListMemberships

      def list_memberships
        @list_memberships ||= ListMemberships.new self
      end

      class ListMemberships

        def initialize client
          @client = client
        end

        def query params
          result = get "/do/query", params, "result"
          result["total_results"] = result["total_results"].to_i if result["total_results"]
          result
        end

        def read_by_id id, params = {}
          get "/do/read/id/#{id}", params
        end

        protected

        def get path, params = {}, result = "listMembership"
          response = @client.get "listMembership", path, params
          result ? response[result] : response
        end

      end

    end
  end
end