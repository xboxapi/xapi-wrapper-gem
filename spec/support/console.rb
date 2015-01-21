require_relative "../../lib/xbox-api.rb"
require 'dotenv'
Dotenv.load
client = XboxApi::Client.new(ENV["XBOX_TOKEN"])
