require_relative 'repos.rb'

module Songify
  module Repositories
    class ArtistsSongs < Repo

      def build_artist(hash)
        Songify::Artist.new({:name => hash[:name]})
      end

      def create_table
        query = <<-SQL
        CREATE TABLE IF NOT EXISTS artists_songs (
          id SERIAL PRIMARY KEY,
          artist_id INTEGER REFERENCES artists (id) ON DELETE CASCADE,
          song_id INTEGER REFERENCES songs (id) ON DELETE CASCADE
        );
        SQL
        @db_adapter.exec(query)
      end

      def view_artists(song_id)
        query = <<-SQL
          SELECT name from artists
          INNER JOIN artists_songs
          ON (artists.id = artist_id)
          WHERE song_id = '#{song_id}'
        SQL
        result = @db_adapter.exec(query).entries

        if result.empty?
          return nil
        else
          result.map {|hash| build_artist(clean_hash(hash)) }
        end
      end

      def delete_artist(song_id)
        query = <<-SQL
          DELETE FROM artists_songs
          WHERE song_id = '#{song_id}';
        SQL
        @db_adapter.exec(query)
      end

    end
  end
end