require_relative 'lib/songify.rb'

#db is songify

Songify.songs_repo = Songify::Repositories::Songs.new
Songify.genres_repo = Songify::Repositories::Genres.new