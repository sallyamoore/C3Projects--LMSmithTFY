require 'httparty'

class SongsController < ApplicationController

  # CALLBACK_URL = "http://localhost:3000/callback/"
  SPOTIFY_URI = "https://api.spotify.com/v1/search?q=The+Smiths"
  # DOMAIN = "localhost"
  # https://play.spotify.com/artist/3yY2gUcIsjMr8hjo51PoJ8
  def index; end

  def search
    if params[:search]
      query = params[:search].downcase
      @songs = sort_and_limit_results(query)
    end

    top_match = @songs.first.title # returns title of top match
    # replace whitespace with +
    top_match = top_match.gsub(" ", "+")
    @data = query_api(top_match)
    # render "/query_api/#{@top_match}"
# raise
  end

  def query_api(top_match)
    begin
      response = HTTParty.get("#{SPOTIFY_URI}+#{top_match}+&type=track")
      data =  setup_data(response)
      code = :ok
    rescue
      data = {}
      code = :no_content
    end
# raise
    return data
  end

  private

  def setup_data(response)
    track = {"song" => {}}
    track["song"]["spotify_url"] = response["tracks"]["items"].first["external_urls"]["spotify"]
    track["song"]["href"] = response["tracks"]["items"].first["href"]
    track["song"]["id"] = response["tracks"]["items"].first["id"]
    track["song"]["uri"] = response["tracks"]["items"].first["uri"]

    return track
  end

  def sort_and_limit_results(query)
    songs = Song.search(query).order(:title)
    songs = songs.sort_by do |song|
      -song.lyrics.downcase.scan(query).size
    end

    return songs.take(5)
  end
end
