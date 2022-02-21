namespace :spotify do
  require 'rspotify'
  require 'json'
  #API_CONFIG = YAML.load_file(Rails.root.join('config', 'api_config.yml'))[Rails.env]
  desc "TODO"
  task load_data: :environment do
    RSpotify.authenticate(API_CONFIG["client_id"], API_CONFIG["client_secret"])
    artists_list = API_CONFIG["artists"]
    
    artists_list.each do |artist_name|
      artists = RSpotify::Artist.search("#{artist_name}",market: 'CO')
      if !artists.nil? && !artists.empty? then
        dataArtist = artists.first
        image  = dataArtist.images.first
        artist = Artist.create( name:dataArtist.name, image: image["url"], genres: dataArtist.genres.join(','), popularity: dataArtist.popularity, spotify_url: dataArtist.href, spotify_id: dataArtist.id )
        artistId = artist.id
        if !dataArtist.albums.nil? && !dataArtist.albums.empty? then
          dataArtist.albums.each do |album| 
            if !album.images.nil? && !album.images.first.nil? && !album.images.length != 0 then 
              imageUrl = album.images.first["url"]
            else
              imageUrl = '#'
            end
            albumData = Album.create( name: album.name, image: imageUrl, spotify_url: album.href, total_tracks: album.total_tracks,spotify_id: album.id, artist_id: artistId ) 
            albumId = albumData.id

            if !album.tracks.nil? && !album.tracks.empty? then
              album.tracks.each do |track| 
                Song.create( name: track.name, explicit: track.explicit, spotify_url: track.href, preview_url: track.preview_url, duration_ms: track.duration_ms, album_id: albumId, spotify_id: track.id )
              end
            end

          end          
        end
      end
      
    end
  end

end
