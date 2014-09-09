module Songify
  class Song
    attr_reader :title, :id

    def initialize(params)
      @title = params.fetch(:title)

      # id is set when added to the db
      @id = nil
      
    #   @artist = params.fetch(:artist)
    #   @genre = params[:genre] 
    #   @album = params[:album]
    #   @rating = params[:rating]
    end
  end
end