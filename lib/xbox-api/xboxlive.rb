require 'thor'
require 'fileutils'

module XboxApi

  LIVE_DIR   = ".live"
  TOKEN_FILE = "live-token"


  class XboxLive < Thor
    package_name "xbl"
    map "-s" => :status

    desc "status GAMERTAG","get the xbox live status of a user"
    def status(gamertag)
      token = TokenHelper.token_exists? ? \
        TokenHelper.get_local_token : \
        TokenHelper.first_run

      client = Client.new(token)
      puts client.gamer(gamertag).presence
    end

    desc "token","re/set your XboxApi token"
    method_options :clear => :boolean
    def token
      if options.clear?

        if TokenHelper.token_exists?
          TokenHelper.clear!;
          puts("Token deleted. Rerun `xbl token` to enter a new token")
        else
          puts("No token exists. Rerun `xbl token` to enter a new token")
        end
        
      else
        puts TokenHelper.token_exists? ? TokenHelper.get_local_token : TokenHelper.first_run
      end
    end

  end

  module TokenHelper
    extend self

    def first_run
      write_local_token!(get_token)
      puts "Token saved!"
    end

    def clear!
      if token_exists?
        FileUtils.rm token_file
      end
    end

    def write_local_token!(token)
      create_token_dir! unless Dir.exists? token_path
      File.write(token_file, token)
      token
    end

    def create_token_dir!
      Dir.mkdir(token_path)
    end

    def token_exists?
      File.exists?(token_file)
    end

    def get_local_token
      raise "No Token Found at #{token_path}" unless token_exists?
      File.read(token_file).chomp
    end

    def token_path
      File.join(Dir.home, XboxApi::LIVE_DIR)
    end

    def token_file
      File.join(token_path, XboxApi::TOKEN_FILE)
    end

    def get_token
      print 'XboxAPI Token: '
      username = $stdin.gets.chomp
    end

  end
end
