module XboxApi
  class GameData

    attr_reader :client, :param

    ENDPOINTS = [
      :game_clips,           # This is the saved game clips for a specified Game (titleId)
      :screenshots,          # This is the saved screenshots for a specified Game (titleId)
      :game_details,         # This is the Xbox Game Information (using the product id)
      :game_details_hex,     # This is the Xbox Game Information (using the game id in hex format)
      :latest_xbox360_games, # This gets the latest Xbox 360 Games from the Xbox LIVE marketplace
      :latest_xboxone_games, # This gets the latest Xbox One Apps from the Xbox LIVE marketplace
      :xbox_gold_lounge      # These are the free "Games with Gold", and "Deals with Gold" from the Xbox LIVE marketplace
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

    # Available sort_options params
    #
    # All Time Average Rating:   "allTimeAverageRating",
    # All Time Play Count:       "allTimePlayCount",
    # All Time Purchase Count:   "allTimePurchaseCount",
    # All Time Rating Count:     "allTimeRatingCount",
    # All Time Rental Count:     "allTimeRentalCount",
    # All Time User Rating:      "allTimeUserRating",
    # Critic Rating:             "criticRating",
    # Digital Release Date:      "digitalReleaseDate",
    # Free And Paid Count Daily: "freeAndPaidCountDaily",
    # Most Popular:              "mostPopular",
    # Paid Count All Time:       "paidCountAllTime",
    # Paid Count Daily:          "paidCountDaily",
    # Release Date:              "releaseDate",
    # Seven Days Average Rating: "sevenDaysAverageRating",
    # Seven Days Play Count:     "sevenDaysPlayCount",
    # Seven Days Purchase Count: "sevenDaysPurchaseCount",
    # Seven Days Rental Count:   "sevenDaysRentalCount",
    # Seven Days Rating Count:   "sevenDaysRatingCount",
    # User Rating:               "userRating"

    # Browse the Xbox LIVE marketplace for Xbox One content.
    #
    def xbox_one_games(page, sort_type = 'releaseDate')
      endpoint = "browse-xboxone/games/#{page}?sort=#{sort_type}"
      client.fetch_body_and_parse( endpoint )
    end

    # Browse the Xbox LIVE marketplace for Xbox One content.
    #
    def xbox_one_apps(page, sort_type = 'releaseDate')
      endpoint = "browse-xboxone/apps/#{page}?sort=#{sort_type}"
      client.fetch_body_and_parse( endpoint )
    end
  end
end
