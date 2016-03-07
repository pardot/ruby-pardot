module Pardot
  module Objects
    module Accounts
      def accounts
        @accounts ||= Accounts.new self
      end

      class Accounts

        def initialize client
          @client = client
        end

        def read params = {}
          get "/do/read", params
        end

        protected

        def get path, params = {}, result = "account"
          response = @client.get "account", path, params
          result ? response[result]: response
        end

        def post path, params = {}, result = "account"
          response = @client.post "account", path, params
          result ? response[result] : response
        end
      end
    end
  end
end
