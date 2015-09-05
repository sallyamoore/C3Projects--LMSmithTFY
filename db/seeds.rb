# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

CSV.foreach("db/albums.csv", headers: true, col_sep: ";") do |row|
  Album.create!(album: row[0], year: row[1])
end

CSV.foreach("db/songs.csv", headers: true, col_sep: ";") do |row|
  Song.create!(title: row[0], lyrics: row[1])
end

# starting to seed foreign key relationships; stopped at song 21 (end of album 2) for now.
songs_albums = { 1 => [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
  2 => [1, 2, 6, 7, 8, 9, 12, 13, 14, 16, 17, 18, 19, 20, 21],
  # 3 => [],
  # 4 => [],
  # 5 => [],
  # 6 => [8, 12, 13, 14, 16, 17, 19, 20, 21],
  # 7 => []
}

songs_albums.each do |album, song|
  album = Album.find(album)
  song.each do |s|
    album.songs << Song.find(s)
  end
end
