require 'rails_helper'

ITUNES_SEARCH = { cassette_name: "itunes_search", record: :new_episodes }

RSpec.describe SongsController, type: :controller do
  describe "GET #index" do
    it "should be successful" do
      get :index
      expect(response).to be_ok
    end

    it "renders the :index view" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #feeling_miserable", vcr: ITUNES_SEARCH do
    before :each do
      @song = create :song
      album = create :album
      @song.albums << album
      get :feeling_miserable
    end

    it "is successful" do
      expect(response).to be_ok
    end

    it "retrieves a song object" do
      expect(assigns(:random_song).id).to eq(@song.id)
      expect(assigns(:random_song).title).to eq(@song.title)
      expect(assigns(:random_song).albums).to eq(@song.albums)
    end

    it "renders the :feeling_miserable view" do
      expect(response).to render_template(:feeling_miserable)
    end
  end

  describe "Searching the db and api for relevant lyrics", vcr: ITUNES_SEARCH do
    describe "GET #search" do
      context "valid search query" do
        before :each do
          @song = create :song
          album = create :album
          @song.albums << album
          get :search, search: "job"
        end

        it "is successful" do
          expect(response).to be_ok
        end

        it "finds relevant songs from the database by searching lyrics" do
          expect(assigns(:songs).first.id).to eq(@song.id)
          expect(assigns(:songs).first.title).to eq(@song.title)
          expect(assigns(:songs).first.albums).to eq(@song.albums)
        end

        it "uses database info to query the api" do
          expect(assigns(:data)[:data]).to include("previewUrl", "trackViewUrl")
        end

        it "renders the search template" do
          expect(response).to render_template("songs/search")
        end
      end
    end

    context "invalid search query" do
      before :each do
        @song = create :song
        album = create :album
        @song.albums << album
        get :search, search: "ridonkulous"
      end

      it "should not find any songs" do
        expect(assigns(:songs).count).to eq(0)
      end

      it "should not get info from the api" do
        expect(assigns(:data)).to eq(nil)
      end

      it "displays an error message" do
        expect(flash[:error]).to_not be nil
      end

      it "redirects to root" do
        expect(response).to redirect_to(root_path)
      end
    end

    context "empty search query" do
      before :each do
        @song = create :song
        album = create :album
        @song.albums << album
        get :search
      end

      it "should not find any songs" do
        expect(assigns(:songs)).to be(nil)
      end

      it "displays an error message" do
        expect(flash[:error]).to_not be nil
      end

      it "redirects to root" do
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
