require "net/http"
require "open-uri"
 
module XboxApi
  class Gamer

    attr_reader :gamertag

    def initialize(gamertag, client)
      @gamertag = gamertag
      @client   = client
      @xuid     = fetch_xuid
    end

    def presence  
      endpoint = "#{xuid}/presence"
      get_with_token( endpoint )
    end

    

    private

    attr_reader :client, :xuid

    def fetch_xuid
      endpoint = "xuid/#{gamertag}"
      get_with_token(endpoint)
    end

    def get_with_token(endpoint)
      request  = URI.parse("#{client.base_url}/#{endpoint}")
      response = open(request, "X-AUTH" => client.api_key)
      response.read
    end


  end

end
