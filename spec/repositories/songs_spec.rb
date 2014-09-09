require_relative '../spec_helper.rb'

describe Songify::Repositories::Songs do
  # songs
  let(:song) do
    Songify::Song.new({
      title: "2 On",
      artist: "Tinashe",
      album: "Aquarius",
      rating: 5
      })
  end
  let (:song2) do
    Songify::Song.new({
      title: "Kiss From a Rose",
      artist: "Seal",
      genre: "Pop",
      album: "Seal",
      rating: 10
      })
  end

  describe '#add_song' do
    it 'adds song to the database' do
      result = Songify.songs_repo.add_song(song)
      expect(result).to eq(1)
    end

    it 'increments id' do 
      Songify.songs_repo.add_song(song)
      result = Songify.songs_repo.add_song(song2)
      expect(result).to eq(2)
    end
  end

  describe '#view_song' do
    it 'returns nil if no song with id' do 

    end

    it 'returns song object with matching id' do 
    end
  end
end