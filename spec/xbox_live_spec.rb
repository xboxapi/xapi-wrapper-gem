require 'spec_helper'

describe XboxLive do
  describe ".profile" do
    context "when the gamertag exists" do
      before do
        Faraday.stub("get").
          with('http://www.xboxleaders.com/api/profile.json?gamertag=nicolasjensen').
          and_return(double(:body => File.open("spec/support/profile.json")))
      end
      it "should return a hash with the profile data" do
        XboxLive.profile("nicolasjensen")["Data"]["Gamertag"].should be_== "nicolasjensen"
      end
    end
  end

  describe ".games" do
    context "when the gamertag exists" do
      before do
        Faraday.stub("get").
          with('http://www.xboxleaders.com/api/games.json?gamertag=nicolasjensen').
          and_return(double(:body => File.open("spec/support/games.json")))
      end
      it "should return a hash with the games data" do
        XboxLive.games("nicolasjensen")["Data"]["PlayedGames"][0]["Title"].should be_== "FIFA 13"
      end
    end
  end

  describe ".achievements" do
    context "when the gamertag exists and the title id too" do
      before do
        Faraday.stub("get").
          with('http://www.xboxleaders.com/api/achievements.json?gamertag=nicolasjensen&titleid=1161890128').
          and_return(double(:body => File.open("spec/support/achievements.json")))
      end
      it "should return a hash with the achievements data" do
        XboxLive.achievements("nicolasjensen", "1161890128")["Data"]["Achievements"][0]["Title"].should be_== "Scrap Metal"
      end
    end
  end

  describe ".friends" do
    context "when the gamertag exists" do
      before do
        Faraday.stub("get").
          with('http://www.xboxleaders.com/api/friends.json?gamertag=nicolasjensen').
          and_return(double(:body => File.open("spec/support/friends.json")))
      end
      it "should return a hash with the friends data" do
        XboxLive.friends("nicolasjensen")["Data"]["Friends"][0]["Gamertag"].should be_== "cccav"
      end
    end
  end
end
