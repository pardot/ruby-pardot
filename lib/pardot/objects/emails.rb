module Pardot
  module Objects
    module Emails
      
      def emails
        @emails ||= Emails.new self
      end
      
      class Emails < ::Pardot::Objects::BaseObject
        OBJECT_NAME = 'email'

        # See: http://developer.pardot.com/kb/api-version-3/reading-emails for valid params
        def read_by_id id, params = {}
          get "/do/read/id/#{id}", params
        end

        # See: http://developer.pardot.com/kb/api-version-3/sending-one-to-one-emails for valid params
        def send_by_id prospect_id, params = {}
          post "/do/send/prospect_id/#{prospect_id}", params
          # campaign_id, (email_template_id OR (text_content, name, subject, & ((from_email & from_name) OR from_user_id))
        end

        # See: http://developer.pardot.com/kb/api-version-3/sending-one-to-one-emails for valid params
        def send_by_email prospect_email, params = {}
          post "/do/send/prospect_email/#{prospect_email}", params
        end

        # See: http://developer.pardot.com/kb/api-version-3/sending-list-emails for valid params
        def send_to_lists campaign_id, list_ids, params = {}
          post 'do/send', params.merge(:list_ids => [*list_ids], :campaign_id => campaign_id)
        end
      end
    end
  end
end
