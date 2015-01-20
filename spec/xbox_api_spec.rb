require 'spec_helper'
require 'vcr'

describe "Gem" do

let(:token)  {File.read('./.env').chomp.split(" ")[1]}
let(:client) {XboxApi::Client.new(token)}
let(:gamer)  do 
  VCR.use_cassette("gamer") { client.gamer("audibleblink") }
end

describe XboxApi::Client do
  

  context "#gamer" do 

    it "returns a Gamer object" do
      expect( gamer ).to be_a_kind_of XboxApi::Gamer
    end

  end

  context "#calls_remaining" do 
    it "return a hash with the correct info" do
      VCR.use_cassette("calls_remaining") do
        response = client.calls_remaining
        expect(response).to be_a_kind_of Hash
      end
    end
  end
end

describe XboxApi::Gamer do

  context "#presence" do 
    it "returns a players presence info" do
      VCR.use_cassette("presence") do
        response = gamer.presence
        expect(response).to be_a_kind_of Hash
      end
    end
  end
end

end
