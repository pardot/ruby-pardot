module Pardot
  module Http
    def get(object, path, params = {}, num_retries = 0)
      smooth_params object, params
      full_path = fullpath object, path
      headers = create_auth_header object
      check_response self.class.get(full_path, query: params, headers: headers)
    rescue Pardot::ExpiredApiKeyError => e
      handle_expired_api_key :get, object, path, params, num_retries, e
    rescue SocketError, Interrupt, EOFError, SystemCallError, Timeout::Error, MultiXml::ParseError => e
      raise Pardot::NetError, e
    end

    def post(object, path, params = {}, num_retries = 0, bodyParams = {})
      smooth_params object, params
      full_path = fullpath object, path
      headers = create_auth_header object
      check_response self.class.post(full_path, query: params, body: bodyParams, headers: headers)
    rescue Pardot::ExpiredApiKeyError => e
      handle_expired_api_key :post, object, path, params, num_retries, e
    rescue SocketError, Interrupt, EOFError, SystemCallError, Timeout::Error, MultiXml::ParseError => e
      raise Pardot::NetError, e
    end

    protected

    # @deprecated With Salesforce OAuth, this method will never be invoked.
    def handle_expired_api_key(method, object, path, params, num_retries, e)
      raise e unless num_retries == 0

      reauthenticate

      send(method, object, path, params, 1)
    end

    def smooth_params(object, params)
      return if object == 'login'

      authenticate unless authenticated?
      params.merge! format: @format
    end

    def create_auth_header(object)
      return if object == 'login'

      if using_salesforce_access_token?
        {
          :Authorization => "Bearer #{@salesforce_access_token}",
          'Pardot-Business-Unit-Id' => @business_unit_id
        }
      else
        { Authorization: "Pardot api_key=#{@api_key}, user_key=#{@user_key}" }
      end
    end

    def check_response(http_response)
      rsp = http_response['rsp']

      error = rsp['err'] if rsp
      error ||= "Unknown Failure: #{rsp.inspect}" if rsp && rsp['stat'] == 'fail'
      content = error['__content__'] if error.is_a?(Hash)

      if [error, content].include?('access_token is invalid') && using_salesforce_access_token?
        raise AccessTokenExpiredError,
              'Access token is invalid. Use Salesforce OAuth to refresh the existing Salesforce access token or to retrieve a new token. See https://developer.salesforce.com/docs/atlas.en-us.mobile_sdk.meta/mobile_sdk/oauth_refresh_token_flow.htm for more information.'
      end
      raise ExpiredApiKeyError, @api_key if [error, content].include?('Invalid API key or user key') && @api_key

      raise ResponseError, error if error

      rsp
    end

    def fullpath(object, path)
      full = File.join('/api', object, 'version', @version.to_s)
      full = File.join(full, path) unless path.nil?
      full
    end
  end
end
