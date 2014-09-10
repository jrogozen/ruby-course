require_relative 'songify/entities/song.rb'
require_relative 'songify/entities/genre.rb'
require_relative 'songify/repositories/songs.rb'
require_relative 'songify/repositories/repos.rb'
require_relative 'songify/repositories/genres.rb'

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
end

module Songify
  module Repositories
    def self.create_tables
      Songify.genres_repo.create_table
      Songify.songs_repo.create_table
    end

    def self.drop_tables
      query = <<-SQL
        DROP TABLE IF EXISTS songs CASCADE;
        DROP TABLE IF EXISTS artists CASCADE;
        DROP TABLE IF EXISTS genres CASCADE;
      SQL
      db_adapter = PG.connect(host: 'localhost', dbname: 'songify')
      db_adapter.exec(query)
    end
  end
end