module Songify
  class Artist
    attr_accessor :id
    attr_reader :name

    def initialize(params)
      @name = params[:name]

      # id set in repo
      @id = params[:id]
    end
  end
end  