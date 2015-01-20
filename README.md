# Desciption

This is a Ruby wrapper for the unofficial Xbox API located at http://xboxapi.com

# Usage

One must first create a client that is able to interface with the Xbox API.  
The client takes one argument; your xbox API token.

```ruby
require "xbox-api"
client = XboxApi::Client.new("424242424242424242424242")
#=> <XboxApi::Client:0x007fcc9215c8e8>

```

Using that client, one can then return a Gamer object

```ruby
logan = client.gamer("oh hai loganz")
```

The XboxApi::Gamer instance responds to methods that correspond to API endpoints

```ruby
logan.presence
logan.gamercard
```

The client also respond to `#calls_emaining`

```ruby
live.calls_remaining
#=> {:limit=>"120", :remaining=>"112", :resets_in=>"452"}
```

# The API

### Currently Supported Endpoints

| Endpoint | Name |  Short Description |
|---       |---   |---                 |
| /v2/{xuid}/profile | Profile | This is the Profile for a specified XUID|
| /v2/{xuid}/gamercard | Gamercard | This is the Gamercard information for a specified XUID|
| /v2/{xuid}/presence | Presence | This is the current presence information for a specified XUID|
| /v2/{xuid}/activity | Activity | This is the current activity information for a specified XUID|
| /v2/{xuid}/activity/recent | Recent Activity | This is the recent activity information for a specified XUID|
| /v2/{xuid}/friends | Friends | This is the friends information for a specified XUID|
| /v2/{xuid}/followers | Followers | This is the followers information for a specified XUID|
| /v2/{xuid}/xbox360games | Xbox 360 Games | This is the Xbox 360 Games List for a specified XUID|
| /v2/{xuid}/xboxonegames | Xbox ONE Games | This is the Xbox One Games List for a specified XUID|
