module Pardot
  module Objects
    module Prospects
      
      def prospects
        @prospects ||= Prospects.new self
      end
      
      class Prospects < ::Pardot::Objects::BaseObject
        OBJECT_NAME = 'prospect'

        def assign_by_email email, params
          post "/do/assign/email/#{email}", params
        end
        
        def assign_by_id id, params
          post "/do/assign/id/#{id}", params
        end
        
        def create email, params = {}
          post "/do/create/email/#{email}", params
        end
        
        def read_by_email email, params = {}
          post "/do/read/email/#{email}", params
        end
        
        def read_by_id id, params = {}
          post "/do/read/id/#{id}", params
        end
        
        def update_by_email email, params = {}
          post "/do/update/email/#{email}", params
        end
        
        def update_by_id id, params = {}
          post "/do/update/id/#{id}", params
        end
        
        def upsert_by_email email, params = {}
          post "/do/upsert/email/#{email}", params
        end
        
        def upsert_by_id id, params = {}
          post "/do/upsert/id/#{id}", params
        end
      end
    end
  end
end
