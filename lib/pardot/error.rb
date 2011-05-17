module Pardot
  
  class Error < StandardError; end
  class NetError < Error; end
  class ResponseError < Error; end
  class ExpiredApiKeyError < Error; end
  
end
