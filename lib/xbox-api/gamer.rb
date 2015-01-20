module XboxApi
  class Gamer

    attr_reader :gamertag, :xuid

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
        client.fetch_body_and_parse( endpoint )
      end
    end

    def recent_activity
      endpoint = "#{xuid}/activity/recent"
      client.fetch_body_and_parse( endpoint )
    end

    private

      attr_reader :client

      def fetch_xuid
        endpoint = "xuid/#{URI.encode(gamertag)}"
        client.fetch_body_and_parse(endpoint)
      end
  end

end
