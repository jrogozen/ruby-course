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

      def build_entity(hash)
        Songify::Artist.new({
            :name => hash[:name],
            :id => hash[:id]
          })
      end

      def save_artist(artist)
        # check for existing artist
        query = <<-SQL
          SELECT * FROM artists
          WHERE name ~~* '#{artist.name}';
        SQL
        result = @db_adapter.exec(query).first

        if result.nil? 
          # add to database
          query = <<-SQL
            INSERT INTO artists (name)
            VALUES ($1)
            RETURNING *;
          SQL
          result = @db_adapter.exec(query, [artist.name])
          artist.instance_variable_set("@id", result.first["id"].to_i)
        else
          query = <<-SQL
            SELECT id FROM artists
            WHERE name ~~* '#{artist.name}';
          SQL
          @db_adapter.exec(query).first["id"].to_i
        end
      end


    end
  end
end