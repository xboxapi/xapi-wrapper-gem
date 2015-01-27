require 'spec_helper'

describe XboxApi do

let(:token)  { ENV['XBOX_TOKEN'] }
let(:client) { XboxApi::Client.new(token) }
let(:gamer)  { VCR.use_cassette("gamer") { client.gamer("audibleblink") } }

  describe XboxApi::Client do

    context "#gamer" do 

      it "returns a Gamer object" do
        expect( gamer ).to be_a_kind_of XboxApi::Gamer
      end

    end

    context "#calls_remaining" do 
      it "returns a hash with the correct info" do
        VCR.use_cassette("calls_remaining") do
          response = client.calls_remaining
          expect(response).to be_a_kind_of Hash
          expect(response.keys.length).to eq 3
        end
      end
    end
  end


  describe XboxApi::Gamer do

    context "#presence" do 
      
      it "returns 'Offline' for an offline player" do
        VCR.use_cassette("presence_offline") do
          response = gamer.presence
          expect(response[:state]).to eq "Offline"
        end
      end

      it "returns 'Online' for an online player" do
        VCR.use_cassette("presence_online") do
          response = gamer.presence
          expect(response[:state]).to eq "Online"
        end
      end
    end

    context "#xuid" do  
      it "has an xuid" do
        expect(gamer.xuid).to_not be nil
      end
    end

    context "#friends" do  
      it "returns an array of friends" do
        VCR.use_cassette("friends") do
          response = gamer.friends
          expect(response).to be_a_kind_of Array
          expect(response.first).to be_a_kind_of Hash
          expect(response.first.has_key?(:id)).to be true
        end
      end
    end

    context "#followers" do  
      it "returns an array of followers" do
        VCR.use_cassette("followers") do
          response = gamer.followers
          expect(response).to be_a_kind_of Array
          expect(response.first).to be_a_kind_of Hash
        end
      end
    end

    context "#gamercard" do  
      it "returns the users gamercard" do
        VCR.use_cassette("gamercard") do
          response = gamer.gamercard
          expect(response).to be_a_kind_of Hash
          expect(response[:gamertag].downcase).to eq gamer.gamertag
        end
      end
    end

    context "#activity" do  
      it "returns the users activity" do
        VCR.use_cassette("activity") do
          response = gamer.activity
          expect(response).to be_a_kind_of Hash
          expect(response.keys.include?(:activityItems)).to be true
        end
      end
    end

    context "#profile" do  
      it "returns the users profile" do
        VCR.use_cassette("profile") do
          response = gamer.profile
          expect(response).to be_a_kind_of Hash
          expect(response[:id]).to eq gamer.xuid
        end
      end
    end

    context "#game_clips" do  
      it "returns an array of game_clips" do
        VCR.use_cassette("game_clips") do
          response = gamer.game_clips
          expect(response).to be_a_kind_of Array
          expect(response.first.keys.include? :gameClipId).to be true
        end
      end
    end

    context "#xboxonegames" do  
      it "returns an array of xboxonegames" do
        VCR.use_cassette("xboxonegames") do
          response = gamer.xboxonegames
          expect(response).to be_a_kind_of Hash
          expect(response[:titles]).to be_a_kind_of Array
        end
      end
    end

    context "#xbox360games" do  
      it "returns an array of xbox360games" do
        VCR.use_cassette("xbox360games") do
          response = gamer.xbox360games
          expect(response).to be_a_kind_of Hash
          expect(response[:titles]).to be_a_kind_of Array
        end
      end
    end

    context "#recent_activity" do  
      it "returns an array of recent_activity" do
        VCR.use_cassette("recent_activity") do
          response = gamer.recent_activity
          expect(response).to be_a_kind_of Array
          expect(response.first.keys.include?(:startTime)).to be true
        end
      end
    end
  end

  describe XboxApi::XboxLive do
    context "#status" do
      it "displays an status for a valid user" do
        VCR.use_cassette("thor-status-valid") do
          expect{system("xbl -s theschoolmaster")}.to output("").to_stdout
        end
      end

      xit "prompts for token when none is present" do
          XboxApi::TokenHelper.clear!
          expect{system("xbl -s theschoolmaster")}.to output("XboxAPI Token:").to_stdout
      end
    end

    context "#token" do
      let(:token){"123123"}

      it "displays a token" do
          XboxApi::TokenHelper.write_local_token!(token)
          output = `xbl token`.chomp
          expect(output).to eq token
      end

      it "clears a token" do
          XboxApi::TokenHelper.write_local_token!(token)
          warning = `xbl token --clear`.chomp
          expect(warning).to eq("Token deleted. Rerun `xbl token` to enter a new token")
      end
    end

  end

end
