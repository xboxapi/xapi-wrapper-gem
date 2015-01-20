require 'spec_helper'
require 'vcr'

describe XboxApi do

let(:token)  {File.read('./.env').chomp.split(" ")[1]}
let(:client) {XboxApi::Client.new(token)}
let(:gamer)  {  VCR.use_cassette("gamer") { client.gamer("audibleblink") }  }

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

      xit "returns 'Online' for an online player" do
        VCR.use_cassette("presence_online") do
          response = gamer.presence
          expect(response[:state]).to eq "Online"
        end
      end

      xit "returns 'Away' for an away player" do
        VCR.use_cassette("presence_away") do
          response = gamer.presence
          expect(response[:state]).to eq "Away"
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
  end

end
