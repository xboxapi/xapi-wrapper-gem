require "net/http"
require "open-uri"
 
module XboxApi
  class Gamer

    attr_reader :gamertag

    def initialize(gamertag, client)
      @gamertag = gamertag
      @client   = client
      @xuid     = nil
    end

    def presence  
      endpoint = "#{xuid}/#{__method__}"
      get_with_token( endpoint )
    end

    def profile
      endpoint = "#{xuid}/#{__method__}"
      get_with_token( endpoint )
    end

    def gamercard
      endpoint = "#{xuid}/#{__method__}"
      get_with_token( endpoint )
    end

    def activity
      endpoint = "#{xuid}/#{__method__}"
      get_with_token( endpoint )
    end

    private

    attr_reader :client
    attr_accessor :xuid

    def fetch_xuid
      endpoint = "xuid/#{gamertag}"
      get_with_token(endpoint)
    end

    def get_with_token(endpoint)
      self.xuid ||= fetch_xuid
      request     = URI.parse("#{client.base_url}/#{endpoint}")
      response    = open(request, "X-AUTH" => client.api_key)
      response.read
    end


  end

end
