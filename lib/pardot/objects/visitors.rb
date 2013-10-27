module Pardot
  module Objects
    module Visitors
      
      def visitors
        @visitors ||= Visitors.new self
      end
      
      class Visitors < ::Pardot::Objects::BaseObject
        OBJECT_NAME = 'visitor'
        
        def assign id, params = {}
          post "/do/assign/id/#{id}", params
        end
        
        def read id, params = {}
          post "/do/read/id/#{id}", params
        end
      end
    end
  end
end
