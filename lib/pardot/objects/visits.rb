module Pardot
  module Objects
    module Visits
      
      def visits
        @visits ||= Visits.new self
      end
      
      class Visits < ::Pardot::Objects::BaseObject
        OBJECT_NAME = 'visit'
        
        def read id, params = {}
          post "/do/read/id/#{id}", params
        end
      end
    end
  end
end
