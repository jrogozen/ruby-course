require_relative 'repos.rb'

module Songify
  module Repositories
    class Songs < Repo
      def create_table
        query = <<-SQL
        CREATE TABLE IF NOT EXISTS songs (
          id SERIAL PRIMARY KEY,
          title TEXT
        );
        SQL
        @db_adapter.exec(query)
      end

      def add_song(song)
        query = <<-SQL
        INSERT INTO songs (title)
        VALUES ($1)
        RETURNING *;
        SQL
        result = @db_adapter.exec(query, [song.title])
        song.instance_variable_set("@id", result.first["id"].to_i)
      end
    end
  end
end