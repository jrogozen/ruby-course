require_relative 'songify/entities/song.rb'
require_relative 'songify/entities/genre.rb'
require_relative 'songify/entities/artist.rb'


require_relative 'songify/repositories/songs.rb'
require_relative 'songify/repositories/repos.rb'
require_relative 'songify/repositories/genres.rb'
require_relative 'songify/repositories/artists.rb'
require_relative 'songify/repositories/artists_songs.rb'

module Songify
    def self.songs_repo=(x)
      @@songs_repo = x
    end

    def self.songs_repo
      @@songs_repo
    end

    def self.genres_repo=(x)
      @@genres_repo = x
    end

    def self.genres_repo
      @@genres_repo
    end

    def self.artists_repo=(x)
      @@artists_repo = x
    end

    def self.artists_repo
      @@artists_repo
    end

    def self.artists_songs_repo=(x)
      @@artists_songs_repo = x
    end

    def self.artists_songs_repo
      @@artists_songs_repo
    end
end

module Songify
  module Repositories
    def self.create_tables
      Songify.genres_repo.create_table
      Songify.songs_repo.create_table
      Songify.artists_repo.create_table
      Songify.artists_songs_repo.create_table
    end

    def self.drop_tables
      query = <<-SQL
        DROP TABLE IF EXISTS songs CASCADE;
        DROP TABLE IF EXISTS artists CASCADE;
        DROP TABLE IF EXISTS genres CASCADE;
        DROP TABLE IF EXISTS artists_songs CASCADE;
      SQL
      db_adapter = PG.connect(host: 'localhost', dbname: 'songify')
      db_adapter.exec(query)
    end
  end
end