module XboxApi
  class GameData

    attr_reader :client, :title_id

    DATA = [
      :game_clips,           # This is the saved game clips for a specified Game (titleId)
      :screenshots,          # Screenshots For Specified Game 
      :game_details,         # Xbox Game Information (Product ID) 
      :game_details_hex      # Xbox Game Information (Game ID in HEX) 
    ]

    RESOURCES = [
      :addons,               # Xbox Game Addon (DLC) Information (Product ID) 
      :related               # Xbox Related Game Information (Product ID) 
    ]

    LATEST = [
      :latest_xbox360_games, # This gets the latest Xbox 360 Games from the Xbox LIVE marketplace
      :latest_xboxone_games, # This gets the latest Xbox One Apps from the Xbox LIVE marketplace
      :latest_xboxone_apps,  # This gets the latest Xbox One Apps from the Xbox LIVE marketplace
      :xboxone_gold_lounge   # These are the free "Games with Gold", and "Deals with Gold" from the Xbox LIVE marketplace
    ]

    MARKETPLACE = [
      :xbox360,              # Browse the Xbox LIVE marketplace for Xbox 360 content.
      :games,                # Browse the Xbox LIVE marketplace for Xbox One Game content.
      :apps                  # Browse the Xbox LIVE marketplace for Xbox One App content.
    ]

    def initialize(client, title_id)
      @client = client
      @title_id = title_id
    end

    DATA.each do |action|
      define_method( action ) do |title_id = @title_id|
        if action == :game_details_hex
          title_id = convert_title_id_to_hex(title_id)
        end

        endpoint = "#{ __method__ }/#{ title_id }".gsub("_", "-")
        client.fetch_body_and_parse( endpoint )
      end
    end

    RESOURCES.each do |action|
      define_method(action) do |product_id = @title_id, page: 1|
        endpoint = "game-details/#{ product_id }/#{ __method__ }/#{ page }"
        client.fetch_body_and_parse(endpoint)
      end
    end

    LATEST.each do |action|
      define_method( action ) do
        endpoint = "#{ __method__ }".gsub("_", "-")
        client.fetch_body_and_parse( endpoint )
      end
    end

    SORT_OPTIONS = [
      'allTimeAverageRating',
      'allTimePlayCount',
      'allTimePurchaseCount',
      'allTimeRatingCount',
      'allTimeRentalCount',
      'allTimeUserRating',
      'criticRating',
      'digitalReleaseDate',
      'freeAndPaidCountDaily',
      'mostPopular',
      'paidCountAllTime',
      'paidCountDaily',
      'releaseDate',
      'sevenDaysAverageRating',
      'sevenDaysPlayCount',
      'sevenDaysPurchaseCount',
      'sevenDaysRentalCount',
      'sevenDaysRatingCount',
      'userRating'
    ]

    def browse_marketplace(resource, params = {})
      sort_by = params[:sort_by].nil? ? 'releaseDate' : params[:sort_by]
      page = params[:page].nil? ? 1 : params[:page]

      return "Resource '#{resource}' doesn't exist! Please use one of: #{MARKETPLACE.join(', ')}" unless MARKETPLACE.include? resource
      return "Sort By '#{sort_by}' is not a valid Sortable Option! Please use one of: #{SORT_OPTIONS.join(', ')}" unless SORT_OPTIONS.include? sort_by

      endpoint = "browse-marketplace/#{resource}/#{page}/?sort=#{sort_by}"
      client.fetch_body_and_parse( endpoint )
    end

  private

    def convert_title_id_to_hex(title_id)
      title_id = title_id.to_s(16)
    rescue ArgumentError
      title_id = sprintf('%02X', title_id)
    end
  end
end
