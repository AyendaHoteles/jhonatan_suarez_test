class CreateAlbums < ActiveRecord::Migration[6.1]
  def change
    create_table :albums do |t|
      t.string :name
      t.string :image
      t.string :spotify_url
      t.integer :total_tracks
      t.bigint :artist_id 
      t.string :spotify_id

      t.timestamps
    end
  end
end
