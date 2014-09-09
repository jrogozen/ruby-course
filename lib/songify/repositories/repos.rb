require 'pg'

module Songify
  module Repositories
    class Repo
      def initialize
        @db_adapter = PG.connect(host: 'localhost', dbname: 'songify')
      end

      def clean_hash(hash) 
        Hash[hash.map{ |k, v| [k.to_sym, v] }]
      end
    end
  end
end