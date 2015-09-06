# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

CSV.foreach("db/albums.csv", headers: true, col_sep: ";") do |row|
  Album.create!(name: row[0], year: row[1])
end

CSV.foreach("db/songs.csv", headers: true, col_sep: ";") do |row|
  Song.create!(title: row[0], lyrics: row[1])
end

# starting to seed foreign key relationships; stopped at song 21 (end of album 2) for now.
songs_albums = { 1 => [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
  2 => [12, 9, 13, 6, 14, 15, 8, 7, 16, 17, 2, 18, 19, 20, 1, 21 ],
  3 => [22, 23, 24, 25, 26, 14, 27, 28, 29, 30],
  4 => [31, 32, 33, 34, 35, 36, 37, 38, 39, 40],
  5 => [41, 42, 43, 36, 44, 39, 45, 37, 46, 47, 48, 49, 26, 50, 51, 52],
  6 => [53, 54, 45, 55, 48, 43, 41, 19, 44, 12, 50, 16, 42, 52, 13, 51, 20, 8, 56, 21, 17, 47, 46],
  7 => [57, 58, 59, 60, 61, 62, 63, 64, 65, 66]
}

songs_albums.each do |album, song|
  album = Album.find(album)
  song.each do |s|
    album.songs << Song.find(s)
  end
end
