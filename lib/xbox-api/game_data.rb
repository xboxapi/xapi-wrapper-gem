module XboxApi
  class GameData

    attr_reader :client, :param

    ENDPOINTS = [
      :game_clips,
      :screenshots,
      :game_details,
      :game_details_hex,
      :latest_xbox360_games,
      :latest_xboxone_games
    ]

    def initialize(client, param)
      @client = client
      @param  = param
    end

    ENDPOINTS.each do |action|
      define_method( action ) do
        endpoint = "#{__method__}/#{param}".gsub("_", "-")
        client.fetch_body_and_parse( endpoint )
      end
    end
  end
end
