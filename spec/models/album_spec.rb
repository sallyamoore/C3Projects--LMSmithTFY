require 'rails_helper'

RSpec.describe Album, type: :model do
  describe "model validations" do
    it "must have a name" do
      album = build :album, name: nil

      expect(album).not_to be_valid
      expect(album.errors.keys).to include(:name)
    end

    it "must have a year" do
      album = build :album, year: nil

      expect(album).not_to be_valid
      expect(album.errors.keys).to include(:year)
    end

    it "name must be unique" do
      create :album
      album = build :album

      expect(album).not_to be_valid
      expect(album.errors.keys).to include(:name)
    end

    it "can have songs" do
      song = create :song
      album = create :album
      album.songs << song

      expect(album.songs).to include(song)
      expect(album.songs.count).to be 1
    end
  end
end
