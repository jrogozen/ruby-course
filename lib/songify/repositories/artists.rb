require_relative 'repos.rb'

module Songify
  module Repositories
    class Artists < Repo
      def create_table
        query = <<-SQL
        CREATE TABLE IF NOT EXISTS artists (
          id SERIAL PRIMARY KEY,
          name TEXT
        );
        SQL
        @db_adapter.exec(query)
      end

      def add_artist(artist)
        query = <<-SQL
        INSERT INTO artists (name)
        VALUES ($1)
        RETURNING *;
        SQL
        @db_adapter.exec(query, [artist])
      end

      def check_for_artist(artist)
        query = <<-SQL
        SELECT id FROM artists
        WHERE name = '#{artist}'
        SQL
        @db_adapter.exec(query)
      end
    end
  end
end