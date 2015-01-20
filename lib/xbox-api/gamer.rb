require "net/http"
require "open-uri"
 
module XboxApi
  class Gamer

    attr_reader :gamertag
    attr_accessor :xuid

    ENDPOINTS = [
      :presence,
      :profile,
      :gamercard,
      :activity,
      :friends,
      :followers,
      :xbox360games,
      :xboxonegames
    ]

    def initialize(gamertag, client)
      @gamertag = gamertag
      @client   = client
      @xuid     = fetch_xuid
    end

    ENDPOINTS.each do |action|
      define_method( action ) do
        endpoint = "#{xuid}/#{__method__}"
        get_with_token( endpoint )
      end
    end

    def recent_activity
      endpoint = "#{xuid}/activity/recent"
      get_with_token( endpoint )      
    end


    private

    attr_reader :client

    def fetch_xuid
      endpoint = "xuid/#{URI.encode(gamertag)}"
      get_with_token(endpoint)
    end

    def get_with_token(endpoint)
      request     = URI.parse("#{client.base_url}/#{endpoint}")
      response    = open(request, "X-AUTH" => client.api_key)
      response.read
    end

  end

end
