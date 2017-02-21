module XboxApi
  class User

    attr_reader :client

    ENDPOINTS = [
      :profile,
      :accountXuid,
      :messages,
      :conversations,
      :recent_players,
      :activity_feed
    ]

    def initialize(client)
      @client = client
    end

    ENDPOINTS.each do |action|
      define_method( action ) do
        endpoint = "#{__method__}".gsub("_", "-")
        client.fetch_body_and_parse( endpoint )
      end
    end
  end
end
