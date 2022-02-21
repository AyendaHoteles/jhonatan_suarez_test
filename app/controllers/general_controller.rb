class GeneralController < ApplicationController
    def artirts
        render json: { "data" => Artist.all.order(popularity: :desc).select("id,name, image, genres,popularity,spotify_url").strict_loading }
    end
    def albums
        render json: { "data" => Album.select("id,name, image,spotify_url, total_tracks").where( "artist_id = :artist_id", { artist_id: params[:id] } ).strict_loading }
    end
    def songs
        render json: { "data" => Song.select("name, preview_url,spotify_url, duration_ms,explicit").where( "album_id = :album_id", { album_id: params[:id] } ).strict_loading }
    end
    def genres
        render json: { "data" => Song.select("songs.name, songs.preview_url,songs.spotify_url, songs.duration_ms,songs.explicit").joins('INNER JOIN albums ON albums.id = songs.album_id INNER JOIN artists ON artists.id = albums.artist_id ').where( "LOWER(artists.genres) LIKE ?", "%"+params[:genre_name].downcase+"%" ).order('RANDOM()').limit(1) }
    end
    def all
        render json: []
    end
end
