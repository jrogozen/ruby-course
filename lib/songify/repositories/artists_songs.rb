require_relative 'repos.rb'

module Songify
  module Repositories
    class ArtistsSongs < Repo
      def create_table
        query = <<-SQL
        CREATE TABLE IF NOT EXISTS artists_songs (
          id SERIAL PRIMARY KEY,
          artist_id INTEGER REFERENCES artists (id),
          song_id INTEGER REFERENCES songs (id)
        );
        SQL
        @db_adapter.exec(query)
      end
    end
  end
end