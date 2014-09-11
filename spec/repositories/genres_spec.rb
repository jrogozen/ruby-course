require_relative '../spec_helper.rb'

describe Songify::Repositories::Genres do
  # genre
  let(:pop) do 
    Songify::Genre.new({
    :name => "Pop"
    })
  end
  let(:rap) do 
    Songify::Genre.new({
    :name => "Rap"
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

  describe '#all_genres' do 
    it 'returns empty array for no genres' do 
      result = Songify.genres_repo.all_genres
      expect(result).to be_an(Array)
      expect(result.length).to eq(0)
    end

    it 'returns array of multiple genres' do 
      Songify.genres_repo.add_genre(pop)
      Songify.genres_repo.add_genre(rap)
      result = Songify.genres_repo.all_genres

      expect(result).to be_an(Array)
      expect(result.length).to eq(2)
      expect(result.last.name).to eq("Rap")
    end
  end

  describe '#view_genre' do 
    it 'returns nil for no genre' do 
      result = Songify.genres_repo.view_genre(1)
      expect(result).to be_nil
    end

    it 'returns song object with matching id' do
      Songify.genres_repo.add_genre(pop)
      result = Songify.genres_repo.view_genre(1)
      expect(result.name).to eq("Pop")
      expect(result.id).to eq(1)
    end
  end

  describe '#remove_genre' do 
    it 'returns nil if no genre matches id' do
      result = Songify.genres_repo.delete_genre(1)
      expect(result).to be_nil
    end

    it 'deletes from database' do
      Songify.genres_repo.add_genre(pop)
      Songify.genres_repo.delete_genre(1)

      result = Songify.genres_repo.view_genre(1)
      expect(result).to be_nil
    end
  end
end