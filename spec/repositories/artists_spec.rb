require_relative '../spec_helper.rb'

describe Songify::Repositories::Songs do
  # artists
  let (:weezer) do 
    Songify::Artist.new({:name => "Weezer"})
  end
  let (:weezer2) do 
    Songify::Artist.new({:name => "Weezer"})
  end

  describe '#save_artist' do
    it 'saves artist to database' do
      result = Songify.artists_repo.save_artist(weezer)
      expect(result).to eq(1)
    end

    it 'errors if artist exists' do 
      Songify.artists_repo.save_artist(weezer)
      result = Songify.artists_repo.save_artist(weezer2)
      expect(result).to eq(1)
    end
  end

end