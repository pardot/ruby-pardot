module Pardot
  module Authentication
    # @deprecated Use of username and password authentication is deprecated.
    def authenticate
      if using_salesforce_access_token?
        raise 'Authentication not available when using Salesforce access token. See https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/intro_oauth_and_connected_apps.htm for more information.'
      end

      warn '[DEPRECATION] Use of username and password authentication is deprecated in favor of Salesforce OAuth. See https://developer.pardot.com/kb/authentication/ for more information.'
      resp = post 'login', nil, nil, nil, email: @email, password: @password, user_key: @user_key
      update_version(resp['version']) if resp && resp['version']
      @api_key = resp && resp['api_key']
    end

    def authenticated?
      !@api_key.nil? || !@salesforce_access_token.nil?
    end

    def using_salesforce_access_token?
      @salesforce_access_token != nil
    end

    def reauthenticate
      if using_salesforce_access_token?
        raise 'Reauthentication not available when using Salesforce access token. See https://developer.salesforce.com/docs/atlas.en-us.mobile_sdk.meta/mobile_sdk/oauth_refresh_token_flow.htm for more information.'
      end

      warn '[DEPRECATION] Use Salesforce OAuth to refresh the Salesforce access token. See https://developer.salesforce.com/docs/atlas.en-us.mobile_sdk.meta/mobile_sdk/oauth_refresh_token_flow.htm for more information.'
      @api_key = nil
      authenticate
    end

    private

    def update_version(version)
      version = version.last if version.is_a? Array
      @version = version if version.to_i > 3
    end
  end
end
