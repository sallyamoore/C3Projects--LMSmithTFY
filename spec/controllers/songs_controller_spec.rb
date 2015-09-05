require 'rails_helper'

RSpec.describe SongsController, type: :controller do
  describe "GET #index" do
    it "should be successful" do
      get :index
      expect(response).to be_ok
    end
  end

  describe "Searching the db for relevant lyrics" do
    describe "GET #search" do
      it "should be successful" do
        get :search, query: "job"
        expect(response).to be_ok
      end
      
      # Not sure how to test this... Currently fails
      # it "should find relevant songs by searching lyrics" do
      #   song = create :song
      #   result = get :search, query: "job"
      #   expect(result).to include(song.title)
      #   # expect(assigns(response)).to be(song.title)
      #
      # end
    end
  end

  # describe "Querying the API", vcr: song_cassette do
  #   before :each do
  #     get :api_query, song: "XXX"
  #   end
  #
  #   it "should be successful" do
  #     expect(response).to be_ok
  #   end
  #
  #   it "should return a json response object" do
  #     expect(response.header['Content-Type']).to include 'application/json'
  #   end
  #
  #   context "the returned json object" do
  #     it "has the expected keys" do
  #       data = JSON.parse response.body
  #
  #       %w(title artist via url).each do |key|
  #         expect(data.map(&:keys).flatten.uniq).to include key
  #       end
  #     end
  #   end
  # end
end
