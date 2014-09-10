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

      def save_song(song)
        # determine if we should add or update db
        if song.id.nil?
          query = <<-SQL
          INSERT INTO songs (title)
          VALUES ($1)
          RETURNING *;
          SQL
          result = @db_adapter.exec(query, [song.title])
          song.instance_variable_set("@id", result.first["id"].to_i)
        else
          # book is already in db, should be updated
          query = <<-SQL
          UPDATE songs SET (title)
          VALUES ($1)
          SQL
          @db_adapter.exec(sql, [song.title])
        end
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

      def delete_song(id)
        # check to see if song id exists
        if view_song(id)
          query = <<-SQL
          DELETE FROM songs
          WHERE id = '#{id}';
          SQL
          @db_adapter.exec(query)
        else
          return nil
        end
      end

      def delete_all
        query = <<-SQL
        TRUNCATE TABLE songs
        SQL
        @db_adapter.exec(query)
      end

    end
  end
end