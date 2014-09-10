require_relative 'repos.rb'

module Songify
  module Repositories
    class Genres < Repo 
      def create_table
        query = <<-SQL
        CREATE TABLE IF NOT EXISTS genres (
          id SERIAL PRIMARY KEY,
          name TEXT
        );
        SQL
        @db_adapter.exec(query)
      end

      def add_genre(genre)
        if genre.id.nil?
          query = <<-SQL
          INSERT INTO genres (name)
          VALUES ($1)
          RETURNING *;
          SQL
          result = @db_adapter.exec(query, [genre.name])
          genre.instance_variable_set("@id", result.first["id"].to_i)
        else
          query = <<-SQL
          UPDATE genres SET (name)
          VALUES ($1)
          SQL
          @db_adapter.exec(sql, [genre.name])
        end
      end

      def get_name(id)
        query = <<-SQL
        SELECT name from genres
        WHERE id = '#{id}';
        SQL
        @db_adapter.exec(query).first["name"]
      end

    end
  end
end