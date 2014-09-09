require_relative 'lib/songify.rb'

#db is songify

Songify.songs_repo = Songify::Repositories::Songs.new
# Songify.artists_repo = Songify::Repositories::Artists.new
# Songify.artists_songs_repo = Songify::Repositories::ArtistsSongs.new