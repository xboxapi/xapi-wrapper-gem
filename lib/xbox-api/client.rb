module XboxApi

  class Client

    attr_reader :api_key, :base_url

    def initialize(api_key)
      @api_key = api_key
      @base_url = "https://xboxapi.com/v2"
    end

    def gamer(tag)
      XboxApi::Gamer.new(tag, self)
    end

    def credentials
      {token: api_key}
    end

  end

end
