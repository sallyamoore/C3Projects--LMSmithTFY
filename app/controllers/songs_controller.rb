require 'httparty'

class SongsController < ApplicationController

  SPOTIFY_URI = "https://api.spotify.com/v1/search?q=The+Smiths"
  ITUNES_URI = "https://itunes.apple.com/search?term=the+smiths+"

  def index; end

  def search
    if params[:search]
      query = params[:search].downcase
      @songs = sort_and_limit_results(query)
    else
      redirect_to search_path, flash: { error: MESSAGES[:general_error] }
    end

    if @songs.nil? || @songs.empty?
      redirect_to root_path, flash: { error: MESSAGES[:empty_search] }
    else
      top_match = @songs.first.title # returns title of top match
      top_match = top_match.gsub(" ", "+") # replaces whitespace with +
      @data = query_api(top_match)
    end
  end

  def query_api(top_match)
    begin
      response = HTTParty.get("#{ITUNES_URI}+#{top_match}", {format: :json})

      data =  setup_data(response)
      code = :ok
    rescue
      data = {}
      code = :no_content
    end
    return data
  end

  private

  def setup_data(response)
    # track = {"song" => {}}
    # track["results"]["spotify_url"] = response["tracks"]["items"].first["external_urls"]["spotify"]
    # track["song"]["href"] = response["tracks"]["items"].first["href"]
    # track["song"]["id"] = response["tracks"]["items"].first["id"]
    # track["song"]["uri"] = response["tracks"]["items"].first["uri"]
    track = {}
    track["previewUrl"]= response["results"].first["previewUrl"]
    track["trackViewUrl"] = response["results"].first["trackViewUrl"]

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
