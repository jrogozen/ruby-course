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

      def build_entity(params)
        Songify::Song.new({
            title: params[:title],
            id: params[:id].to_i
          })
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

      def view_song(id)
        query = <<-SQL
        SELECT * FROM songs
        WHERE id = '#{id}' 
        SQL
        result = @db_adapter.exec(query).first
        if result
          song = build_entity(clean_hash(result))
        end
      end

      def view_all_songs
        query = <<-SQL
        SELECT * FROM songs;
        SQL
        result = @db_adapter.exec(query).entries

        if result.empty?
          return result
        else
          result.map {|hash| build_entity(clean_hash(hash))}
        end
      end

    end
  end
end