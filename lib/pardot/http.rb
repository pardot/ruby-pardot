module Pardot
  module Http
    
    def get object, path, params = {}
      smooth_params object, params
      path = fullpath object, path
      check_response self.class.get path, :query => params
      
    rescue SocketError, Interrupt, EOFError, SystemCallError => e
      raise Pardot::NetError.new(e)
    end
    
    def post object, path, params = {}
      smooth_params object, params
      path = fullpath object, path
      check_response self.class.post path, :query => params
      
    rescue SocketError, Interrupt, EOFError, SystemCallError => e
      raise Pardot::NetError.new(e)
    end
    
    protected
    
    def smooth_params object, params
      return if object == "login"
      
      authenticate unless authenticated?
      params.merge! :user_key => @user_key, :api_key => @api_key, :format => @format
    end
    
    def check_response http_response
      rsp = http_response["rsp"]
      
      if rsp && rsp["err"]
        raise ResponseError.new rsp["err"]
      end
      
      if rsp && rsp["stat"] == "fail"
        raise ResponseError.new "Unknown Failure: #{rsp.inspect}"
      end
      
      rsp
    end
    
    def fullpath object, path, version = 3
      full = File.join("/api", object, "version", version.to_s)
      unless path.nil?
        full = File.join(full, path)
      end
      full
    end
    
  end
end
