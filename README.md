[![Test Coverage](https://codeclimate.com/github/audibleblink/xbox-api/badges/coverage.svg)](https://codeclimate.com/github/audibleblink/xbox-api)  
![](https://circleci.com/gh/audibleblink/xbox-api.svg?style=shield&circle-token=:circle-token)  
[![Code Climate](https://codeclimate.com/github/audibleblink/xbox-api/badges/gpa.svg)](https://codeclimate.com/github/audibleblink/xbox-api)  


# Description

This is a Ruby wrapper for the unofficial Xbox API located at http://xboxapi.com

#Installation

`gem install xbox-api`

# Usage

## Ruby Gem

One must first create a client that is able to interface with the Xbox API.  
The client takes one argument; your xbox API token.

```ruby
require "xbox-api"
client = XboxApi::Client.new("7ae98726beb982d987e7987ab1239a87")
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

The client also respond to `#calls_remaining`

```ruby
live.calls_remaining
#=> {:limit=>"120", :remaining=>"112", :resets_in=>"452"}
```


If one already has a gamer's XUID, the API lookup normally required to fetch an XUID during initialization may be skipped by passing in a client instance and the gamer's XUID as the third argument.

```ruby
client = XboxApi::Client.new(ENV[:XBOX_TOKEN])
logan = XboxApi::Gamer.new("oh hai loganz", client, "189823798746")
```

## Commad Line

The `xbl` binary may be invoked from the command line.

`xbl -s theschoolmaster` or `xbl --status theschoolmaster` may be used to retreive the status of a given player

If you have not yet supplied your API token from XboxApi.com, you will be prompted when trying to use `xbl`

Additionally, you may clear and set you token with `xbl token`

```sh
# clear your token
xbl token --clear

# set or view your token
xbl token
```


# The API

### Currently Supported Endpoints

| Method Name | Endpoint |  Short Description |
|---       |---   |---                 |
| profile         | /v2/{xuid}/profile         | This is the Profile for a specified XUID|
| gamercard       | /v2/{xuid}/gamercard       | This is the Gamercard information for a specified XUID|
| presence        | /v2/{xuid}/presence        | This is the current presence information for a specified XUID|
| activity        | /v2/{xuid}/activity        | This is the current activity information for a specified XUID|
| recent_activity | /v2/{xuid}/activity/recent | This is the recent activity information for a specified XUID|
| friends         | /v2/{xuid}/friends         | This is the friends information for a specified XUID|
| followers       | /v2/{xuid}/followers       | This is the followers information for a specified XUID|
| xbox360games    | /v2/{xuid}/xbox360games    | This is the Xbox 360 Games List for a specified XUID|
| xboxonegames    | /v2/{xuid}/xboxonegames    | This is the Xbox One Games List for a specified XUID|
| game_clips      | /v2/{xuid}/game-clips      | This is the current collection of clips for a specified XUID|
