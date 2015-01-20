require 'spec_helper'


describe XboxApi do
    
  let(:client) {XboxApi::Client.new("42")}
  let(:gamer)  {client.gamer("audibleblink")}

  describe XboxApi::Client do


    context "#gamer" do 

      it "returns a Gamer object" do
        expect( client.gamer "audibleblink" ).to be_a_kind_of XboxApi::Gamer
      end

    end

  end

end
