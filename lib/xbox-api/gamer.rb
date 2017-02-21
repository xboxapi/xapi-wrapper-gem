module XboxApi
  class Gamer

    attr_reader :gamertag, :xuid

    ENDPOINTS = [
      :profile,
      :gamercard,
      :presence,
      :activity,
      :friends,
      :followers,
      :game_clips,
      :screenshots,
      :xbox360games,
      :xboxonegames,
      :titlehub_achievements_list
    ]

    def initialize(gamertag, client, xuid = nil)
      @gamertag = gamertag
      @client   = client
      @xuid     = xuid || fetch_xuid
    end

    ENDPOINTS.each do |action|
      define_method( action ) do |param = nil|
        parsable_method = __method__.to_s.gsub("_", "-")

        return "Recent Activity param needs to be 'recent', you passed '#{param}'" if (parsable_method == 'activity' && !param.nil?) && param != 'recent'
        return "Game Clips param needs to be 'saved', you passed '#{param}'" if (parsable_method == 'game-clips' && !param.nil?) && param != 'saved'

        endpoint = [xuid, parsable_method]
        endpoint.push(param) unless param.nil?

        client.fetch_body_and_parse(endpoint.join('/'))
      end
    end

    def get_xuid_for(gamertag)
      client.fetch_body_and_parse("xuid/#{gamertag}")
    end

  private

    attr_reader :client

    def fetch_xuid
      endpoint = "xuid/#{URI.encode(gamertag)}"
      client.fetch_body_and_parse(endpoint)
    end
  end
end
