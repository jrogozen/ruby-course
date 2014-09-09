require 'pg'

module Songify
  module Repositories
    class Repo
      def initialize
        @db_adapter = PG.connect(host: 'localhost', dbname: 'songify')
      end
    end
  end
end