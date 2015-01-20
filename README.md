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

# The API

### Endpoints

| Endpoint | Name |  Short Description |
|---       |---   |---                 |
| /v2/xuid/{gamertag} | Gamertag XUID | This is the XUID for a specified Gamertag (Xbox Account User ID)|
| /v2/gamertag/{xuid} | XUID Gamertag | This is the Gamertag for a specified XUID (Xbox Account User ID)|
| /v2/{xuid}/profile | Profile | This is the Profile for a specified XUID|
| /v2/{xuid}/gamercard | Gamercard | This is the Gamercard information for a specified XUID|
| /v2/{xuid}/presence | Presence | This is the current presence information for a specified XUID|
| /v2/{xuid}/activity | Activity | This is the current activity information for a specified XUID|
| /v2/{xuid}/activity/recent | Recent Activity | This is the recent activity information for a specified XUID|
| /v2/{xuid}/friends | Friends | This is the friends information for a specified XUID|
| /v2/{xuid}/followers | Followers | This is the followers information for a specified XUID|
| /v2/{xuid}/game-clips | Game Clips | This is the game clips for a specified XUID|
| /v2/{xuid}/game-clips/saved | Saved Game Clips | This is the saved game clips for a specified XUID|
| /v2/{xuid}/game-stats/{titleId} | Game Stats | This is the game stats for a specified XUID, on a specified game (i.e. Driver Level on Forza)|
| /v2/{xuid}/xbox360games | Xbox 360 Games | This is the Xbox 360 Games List for a specified XUID|
| /v2/{xuid}/xboxonegames | Xbox ONE Games | This is the Xbox One Games List for a specified XUID|
| /v2/{xuid}/achievements/{titleId} | Xbox Game Achievements | This is the Xbox Games Achievements for a specified XUID|


