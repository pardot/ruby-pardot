module Pardot
  module Http
    
    def get object, path, params = {}, num_retries = 0
      smooth_params object, params
      full_path = fullpath object, path
      check_response self.class.get(full_path, :query => params)
      
    rescue Pardot::ExpiredApiKeyError => e
      handle_expired_api_key :get, object, path, params, num_retries, e
      
    rescue SocketError, Interrupt, EOFError, SystemCallError => e
      raise Pardot::NetError.new(e)
    end
    
    def post object, path, params = {}, num_retries = 0
      smooth_params object, params
      full_path = fullpath object, path
      check_response self.class.post(full_path, :body => params)
      
    rescue Pardot::ExpiredApiKeyError => e
      handle_expired_api_key :post, object, path, params, num_retries, e
      
    rescue SocketError, Interrupt, EOFError, SystemCallError => e
      raise Pardot::NetError.new(e)
    end
    
    protected
    
    def handle_expired_api_key method, object, path, params, num_retries, e
      raise e unless num_retries == 0
      
      reauthenticate
      
      send(method, object, path, params, 1)
    end
    
    def smooth_params object, params
      return if object == 'login'
      
      authenticate unless authenticated?
      params.merge! :user_key => @user_key, :api_key => @api_key, :format => @format, :output => @output
    end
    
    def check_response http_response
      rsp = http_response['rsp'] || http_response || {}
      error = rsp['err']
      status = ( rsp['@attributes'] && rsp['@attributes']['stat'] ) || rsp['stat']
      error ||= "Unknown Failure: #{rsp.inspect}" if status == 'fail'
      content = error['__content__'] if error.is_a?(Hash)
      
      if [error, content].include?('Invalid API key or user key') && @api_key
        raise ExpiredApiKeyError.new @api_key
      end
      
      raise ResponseError.new error if error

      rsp
    end
    
    def fullpath object, path, version = 3
      full = File.join('/api', object, 'version', version.to_s)
      unless path.nil?
        full = File.join(full, path)
      end
      full
    end
  end
end
