module Songify
  class Song
    attr_accessor :rating, :artists
    attr_reader :title, :id, :genre, :genre_id, :lyrics

    def initialize(params)
      @title = params.fetch(:title)
      @genre = params[:genre]
      @genre_id = params[:genre_id]
      @lyrics = params[:lyrics]

      @artists = params[:artists] || []
      
      # id is set when added to the db
      @id = params[:id]

      @rating = params[:rating] || 0
    end
  end
end