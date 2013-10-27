module Pardot
  module Objects
    module Users
      
      def users
        @users ||= Users.new self
      end
      
      class Users < ::Pardot::Objects::BaseObject
        OBJECT_NAME = 'user'
        
        def read_by_email email, params = {}
          post "/do/read/email/#{email}", params
        end
        
        def read_by_id id, params = {}
          post "/do/read/id/#{id}", params
        end
      end
    end
  end
end
