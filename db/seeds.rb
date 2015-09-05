# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

CSV.foreach("db/albums.csv", headers: true) do |row|
  Album.create!(album: album, year: year)
end

CSV.foreach("db/songs.csv", headers: true) do |row|
  Songs.create!(title: title, lyrics: lyrics)
end

# example for foreign key relationships
# album_songs = { 1 => [1, 2, 4, 5, 9, 12, 19, 21, 25, 27, 29, 34, 35], 2 => [1, 3, 12, 19, 24, 29, 33, 34, 35], 3 => [7, 13, 14, 15, 16, 17, 18], 4 => [6, 7, 8, 10, 11, 15, 18, 14, 19, 29, 34, 35], 5 => [20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32]}
#
# category_products.each do |k, v|
#   category = Category.find(k)
#   v.each do |p|
#     category.products << Product.find(p)
#   end
# end
