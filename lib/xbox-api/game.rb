module XboxApi
  class Game

    attr_reader :xuid, :client, :title_id

    ENDPOINTS = [
      :game_clips,
      :screenshots,
      :game_stats,
      :achievements
    ]

    def initialize(xuid, client, title_id)
      @xuid     = xuid
      @client   = client
      @title_id = title_id
    end

    ENDPOINTS.each do |action|
      define_method( action ) do
        endpoint = "#{xuid}/#{__method__}/#{title_id}".gsub("_", "-")
        client.fetch_body_and_parse( endpoint )
      end
    end
  end
end
