module Pardot
  module Objects
    module Lists
      
      def lists
        @lists ||= Lists.new self
      end
      
      class Lists < ::Pardot::Objects::BaseObject
        OBJECT_NAME = 'list'

        def create id, params = {}
          post '/do/create', params
        end
        
        def read_by_id id, params = {}
          get "/do/read/id/#{id}", params
        end
      end
    end
  end
end
