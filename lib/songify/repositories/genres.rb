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

      def build_entity(hash)
        Songify::Genre.new({
            :name => hash[:name],
            :id => hash[:id]
          })
      end

      def add_genre(genre)
        query = <<-SQL
        SELECT * FROM genres
        WHERE name ~~* '#{genre.name}';
        SQL
        genre_check = @db_adapter.exec(query).first

        if !genre_check.nil?
          return nil
        end

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
          UPDATE genres 
          SET name = '#{genre.name}'
          WHERE id = '#{genre_check["id"]}';
          SQL
          @db_adapter.exec(query)
        end
      end

      def view_genre(id)
        query = <<-SQL
        SELECT * FROM genres
        WHERE id = '#{id}';
        SQL
        result = @db_adapter.exec(query).first
        if result
          genre = build_entity(clean_hash(result))
          genre.instance_variable_set("@id", result["id"].to_i)
          genre
        end
      end

      def get_name(id)
        query = <<-SQL
        SELECT name from genres
        WHERE id = '#{id}';
        SQL
        @db_adapter.exec(query).first["name"]
      end

      def all_genres
        query = <<-SQL
        SELECT * FROM genres;
        SQL
        result = @db_adapter.exec(query).entries
        result.map do |hash|
          build_entity(clean_hash(hash))
        end
      end

      def delete_genre(id)
        # check to see if genre id exists
        if view_genre(id)
          query = <<-SQL
          DELETE FROM genres
          WHERE id = '#{id}';
          SQL
          @db_adapter.exec(query)
        else
          return nil
        end
      end

      def song_count(id)
      end

    end
  end
end