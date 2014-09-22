require_relative 'repos.rb'

module Songify
  module Repositories
    class Songs < Repo
      def create_table
        query = <<-SQL
        CREATE TABLE IF NOT EXISTS songs (
          id SERIAL PRIMARY KEY,
          title TEXT,
          rating INTEGER,
          genre_id INTEGER REFERENCES genres (id),
          lyrics TEXT
        );
        SQL
        @db_adapter.exec(query)
      end

      def build_entity(params)
        Songify::Song.new({
            title: params[:title],
            id: params[:id].to_i,
            rating: params[:rating].to_i,
            genre: params[:genre_name],
            genre_id: params[:genre_id],
            lyrics: params[:lyrics],
            artists: []
          })
      end

      def save_song(song)  
        # do we have to add genre to the db?
        query = <<-SQL
          SELECT * FROM genres
          WHERE name ~~* '#{song.genre.name}'
        SQL
        genre = @db_adapter.exec(query).first

        if genre.nil?
          song.genre.id = Songify.genres_repo.add_genre(song.genre)
        else
          song.genre.id = genre["id"].to_i
        end

        # ensure every artist has an id
        song.artists.each do |artist|
          artist.id = Songify.artists_repo.save_artist(artist)
        end


        # determine if we should add or update db
        if song.id.nil?
          query = <<-SQL
          INSERT INTO songs (title, rating, genre_id, lyrics)
          VALUES ($1, $2, $3, $4)
          RETURNING *;
          SQL
          result = @db_adapter.exec(query, [song.title, song.rating, song.genre.id, song.lyrics])
          song.instance_variable_set("@id", result.first["id"].to_i)
        else
          # song is already in db, should be updated
          query = <<-SQL
          UPDATE songs 
          SET title = '#{song.title}', rating = '#{song.rating}', genre_id = '#{song.genre.id}', lyrics = '#{song.lyrics}'
          WHERE id = '#{song.id}';
          SQL
          @db_adapter.exec(query)
        end

        # add song id and artist id to artists_songs table
        song.artists.each do |artist|
          query = <<-SQL
            INSERT INTO artists_songs (artist_id, song_id)
            VALUES ($1, $2)
            RETURNING *;
          SQL
          result = @db_adapter.exec(query, [artist.id, song.id])
        end

        song.id
      end

      def view_song(value)
        # all artists
        # build an array of artist objects
        # build the song

        if value.is_a? (Integer)

          artists = Songify.artists_songs_repo.view_artists(value)

          query = <<-SQL
            SELECT * FROM songs
            WHERE id = '#{value}' 
          SQL
          result = @db_adapter.exec(query).first
          if result
            result["genre_name"] = Songify.genres_repo.get_name(result["genre_id"])
            
            song = build_entity(clean_hash(result))
            artists.each {|artist| song.artists << artist}
            song
          end

        else

          query = <<-SQL 
            SELECT * FROM songs
            where title ~~* '%#{value}%'
          SQL
          result = @db_adapter.exec(query).first
          if result
            result["genre_name"] = Songify.genres_repo.get_name(result["genre_id"])
            song = build_entity(clean_hash(result))
          end
          
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
          result.map do |hash| 
            hash["genre_name"] = Songify.genres_repo.get_name(hash["genre_id"])
            build_entity(clean_hash(hash))
          end
        end
      end

      def delete_song(id)
        # check to see if song id exists
        if view_song(id)
          query = <<-SQL
          DELETE FROM songs CASCADE
          WHERE id = '#{id}';
          SQL
          @db_adapter.exec(query)
        else
          return nil
        end
      end

      def delete_all
        query = <<-SQL
        TRUNCATE TABLE songs CASCADE
        SQL
        @db_adapter.exec(query)
      end

      def change_rating(id, rating)
        query = <<-SQL
          UPDATE songs
          SET rating = rating + '#{rating}'
          WHERE id = '#{id}'
          RETURNING rating;
        SQL
        result = @db_adapter.exec(query).first
        clean_hash(result)
      end

      def search_lyrics(lyrics)
        query = <<-SQL
          SELECT * FROM songs
          WHERE lyrics ~~* '%#{lyrics}%';
        SQL
        result = @db_adapter.exec(query).entries
        
        result.map {|hash| hash["genre_name"] = Songify.genres_repo.get_name(hash["genre_id"]); build_entity(clean_hash(hash))}
      end

      def sort_songs_by_rating
        songs = view_all_songs
        songs.sort_by {|k| -k.rating}
      end

      def sort_songs_by_title
        songs = view_all_songs
        songs.sort_by {|k| k.title}
      end

      def sort_songs_by_genre
        songs = view_all_songs
        songs.sort_by {|k| k.genre}
      end


    end
  end
end