module Pardot
  class Error < StandardError; end

  class NetError < Error; end

  class ExpiredApiKeyError < Error; end

  class AccessTokenExpiredError < Error; end

  class ResponseError < Error
    def initialize(res)
      @res = res
    end

    def to_s
      @res['__content__']
    end

    def code
      @res['code'].to_i
    end

    def inspect
      @res.inspect.to_s
    end
  end
end
