require 'spec_helper'


describe XboxApi::Client do
    
  let(:client) {XboxApi::Client.new("42")}
  let(:gamer)  {client.gamer("audibleblink")}

  context "#gamer" do 

    xit "returns a Gamer object" do
      # expect( client.gamer "audibleblink" ).to be_a_kind_of XboxApi::Gamer
    end

  end
end

describe XboxApi::Gamer do

  context "#presence" do 
    xit "returns presence information" do
      "must find a way to stub json response"
    end
  end

end
