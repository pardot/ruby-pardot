module Pardot
  module Objects
    module Opportunities

      def opportunities
        @opportunities ||= Opportunities.new self
      end
      
      class Opportunities < ::Pardot::Objects::BaseObject
        OBJECT_NAME = 'opportunity'
        
        def create_by_email email, params = {}
          post "/do/create/prospect_email/#{email}", params
        end
        
        def create_by_id prospect_id, params = {}
          post "/do/create/prospect_id/#{prospect_id}", params
        end
        
        def read_by_id id, params = {}
          post "/do/read/id/#{id}", params
        end
        
        def update_by_id id, params = {}
          post "/do/update/id/#{id}", params
        end
      end
    end
  end
end
