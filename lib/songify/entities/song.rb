module Songify
  class Song
    attr_reader :title, :id, :rating, :genre

    def initialize(params)
      @title = params.fetch(:title)
      @genre = params[:genre]

      # id is set when added to the db
      @id = params[:id]

      @rating = params[:rating] || 0
    end
  end
end