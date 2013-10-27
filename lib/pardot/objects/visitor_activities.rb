module Pardot
  module Objects
    module VisitorActivities
      
      def visitor_activities
        @visitor_activities ||= VisitorActivities.new self
      end
      
      class VisitorActivities < ::Pardot::Objects::BaseObject
        OBJECT_NAME = 'visitorActivity'
        
        def read id, params = {}
          post "/do/read/id/#{id}", params
        end
      end
    end
  end
end
