require 'rails_helper'

RSpec.describe Song, type: :model do
  describe "model validations" do
    it "must have a title" do
      song = build :song, title: nil

      expect(song).not_to be_valid
      expect(song.errors.keys).to include(:title)
    end

    it "must have lyrics" do
      song = build :song, lyrics: nil

      expect(song).not_to be_valid
      expect(song.errors.keys).to include(:lyrics)
    end

    it "title must be unique" do
      create :song
      song = build :song

      expect(song).not_to be_valid
      expect(song.errors.keys).to include(:title)
    end
  end
end
