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
      :xboxonegames,
      :game_clips
    ]

    def initialize(gamertag, client, xuid=nil)
      @gamertag = gamertag
      @client   = client
      @xuid     = xuid || fetch_xuid
    end

    ENDPOINTS.each do |action|
      define_method( action ) do
        endpoint = "#{xuid}/#{__method__}".gsub("_", "-")
        client.fetch_body_and_parse( endpoint )
      end
    end

    def recent_activity
      endpoint = "#{xuid}/activity/recent"
      client.fetch_body_and_parse( endpoint )
    end

    # TODO: These don't belong here
    # [:messages, :recent_players].each do |action|
    #   define_method(action) do
    #     endpoint = __method__.to_s.gsub("_", "-")
    #     client.fetch_body_and_parse( endpoint )      
    #   end
    # end


    private

      attr_reader :client

      def fetch_xuid
        endpoint = "xuid/#{URI.encode(gamertag)}"
        client.fetch_body_and_parse(endpoint)
      end
  end

end
