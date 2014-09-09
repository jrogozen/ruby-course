module Songify
  class Song
    attr_reader :title

    def initialize(params)
      @title = params.fetch(:title)
    #   @artist = params.fetch(:artist)
    #   @genre = params[:genre] 
    #   @album = params[:album]
    #   @rating = params[:rating]
    end
  end
end