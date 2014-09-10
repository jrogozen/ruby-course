module Songify
  class Genre
  attr_accessor :id
  attr_reader :name

    def initialize(params)
      @name = params.fetch(:name)

      # id is set when added to the db
      @id = params[:id]
    end
  end
end