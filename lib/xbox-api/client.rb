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

    def fetch_body_and_parse(endpoint)
      parse(get_with_token(endpoint).read)
    end

    def calls_remaining
      headers = fetch_headers
      {
        limit: headers["x-ratelimit-limit"],
        remaining: headers["x-ratelimit-remaining"],
        resets_in: headers["x-ratelimit-reset"]
      }
    end

    private

    def parse(json)
      Yajl::Parser.parse(json, symbolize_keys: true)
    end

    def get_with_token(endpoint)
      request = URI.parse("#{base_url}/#{endpoint}")
      open(request, "X-AUTH" => api_key, "User-Agent" => "Ruby/XboxApi Gem v#{XboxApi::Wrapper::VERSION}")
    end

    def fetch_headers
      get_with_token("accountXuid").meta
    end
  end
end
