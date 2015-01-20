require "net/http"
require "open-uri"
 
module XboxApi
  class Gamer

    attr_reader :gamertag
    attr_accessor :xuid

    def initialize(gamertag, client)
      @gamertag = gamertag
      @client   = client
      @xuid     = fetch_xuid
    end

    [:presence, :profile, :gamercard, :activity, :friends, :followers]
      .each do |action|
        define_method( action ) do
          endpoint = "#{xuid}/#{__method__}"
          get_with_token( endpoint )
        end
      end


    private

    attr_reader :client

    def fetch_xuid
      endpoint = "xuid/#{gamertag}"
      get_with_token(endpoint)
    end

    def get_with_token(endpoint)
      request     = URI.parse("#{client.base_url}/#{endpoint}")
      response    = open(request, "X-AUTH" => client.api_key)
      response.read
    end

  end

end
