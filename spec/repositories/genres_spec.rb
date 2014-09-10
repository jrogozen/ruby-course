require_relative '../spec_helper.rb'

describe Songify::Repositories::Genres do
  # genre
  let(:pop) do 
    Songify::Genre.new({
    :name => "Pop"
    })
  end

  describe '#add_genre' do 
    it 'adds genre to database and gives it an id' do 
      result = Songify.genres_repo.add_genre(pop)
      expect(result).to eq(1)
    end
  end

  describe '#get_name' do 
    it 'returns correct genre name' do 
      Songify.genres_repo.add_genre(pop)
      result = Songify.genres_repo.get_name(1)
      expect(result).to eq("Pop")
    end
  end
end