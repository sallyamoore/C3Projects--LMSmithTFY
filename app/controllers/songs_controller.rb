require 'httparty'

class SongsController < ApplicationController

  ITUNES_URI = "https://itunes.apple.com/search?term=the+smiths+"
  RESULT_LIMIT = 5

  def index; end

  def search
    if params[:search]
      @songs = sort_and_limit_results(params[:search].downcase)
    else
      @songs = nil
    end

    if @songs.nil? || @songs.empty?
      redirect_to root_path, flash: { error: MESSAGES[:empty_search] }
    else
      top_match = @songs.first.title # returns title of top match
      top_match = top_match.gsub(" ", "+") # replaces whitespace with +
      @data = query_api(top_match)
    end
  end

  def feeling_miserable
    offset = rand(Song.count)
    @random_song = Song.offset(offset).first
    @data = query_api(@random_song.title.gsub(" ", "+"))
    gif_hash = {  gif1: { embed_id: "36cGJoVcFMwQo",
                          height: "355",
                          url_detail: "celebrity-1970s-36cGJoVcFMwQo" },
                  gif2: { embed_id: "NezgviZJGvQ3K",
                          height: "540",
                          url_detail: "morrissey-the-smiths-NezgviZJGvQ3K" },
                  gif3: { embed_id: "PSB2lxGv85gSQ",
                          height: "429",
                          url_detail: "dancing-morrissey-PSB2lxGv85gSQ" },
                  gif4: { embed_id: "SbemvsIiE2fzq",
                          height: "268",
                          url_detail: "morrissey-the-smiths-SbemvsIiE2fzq" },
                  gif5: { embed_id: "ENKbvrwRPrWRa",
                          height: "360",
                          url_detail: "morrissey-zBTxf5MZBgYXm" },
                  gif6: { embed_id: "zBTxf5MZBgYXm",
                          height: "336",
                          url_detail: "morrissey-ENKbvrwRPrWRa" }
                }
    @random_gif = gif_hash[gif_hash.keys.sample]
  end

  def query_api(top_match)
      response = HTTParty.get("#{ITUNES_URI}#{top_match}", {format: :json})

      data =  setup_data(response)
      code = :ok

    return { data: data.as_json, code: code }
  end

  private

  def setup_data(response)
    track = {}
    track["previewUrl"]= response["results"].first["previewUrl"]
    track["trackViewUrl"] = response["results"].first["trackViewUrl"]

    return track
  end

  def sort_and_limit_results(query)
    songs = Song.search(query).order(:title)

    # sort returned songs in descending order by number of matches
    songs = songs.sort_by do |song|
      -song.lyrics.scan(query).size
    end

    # limit to 5 best matches
    return songs.take(RESULT_LIMIT)
  end
end
