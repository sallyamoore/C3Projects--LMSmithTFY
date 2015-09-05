require 'httparty'

class SongsController < ApplicationController

  CALLBACK_URL = "http://localhost:3000/callback/"
  def index; end

  def search
    if params[:search]
      query = params[:search].downcase
      @songs = sort_and_limit_results(query)
    end
  end


  private

  def sort_and_limit_results(query)
    songs = Song.search(query).order(:title)
    songs = songs.sort_by do |song|
      -song.lyrics.downcase.scan(query).size
    end

    return songs.take(5)
  end
end
