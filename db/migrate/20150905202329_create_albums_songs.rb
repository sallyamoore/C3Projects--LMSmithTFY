class CreateAlbumsSongs < ActiveRecord::Migration
  def change
    create_table :albums_songs, id: false do |t|
      t.belongs_to :album, index: true
      t.belongs_to :song, index: true
    end
  end
end
