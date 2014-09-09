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
      result = Songify.songs_repo.view_song(1)
      expect(result).to be_nil
    end

    it 'returns song object with matching id' do 
      Songify.songs_repo.add_song(song)
      result = Songify.songs_repo.view_song(1)
      expect(result.id).to eq(1)
      expect(result.title).to eq("2 On")
    end
  end

  describe 'view_all_songs' do 
    it 'returns empty array for no songs' do
      result = Songify.songs_repo.view_all_songs
      expect(result.length).to eq(0)
    end

    it 'returns array of 1 song object' do 
      Songify.songs_repo.add_song(song)
      result = Songify.songs_repo.view_all_songs

      expect(result).to be_an(Array)
      expect(result.length).to eq(1)
      expect(result[0].title).to eq("2 On")
    end

    it 'returns array of 2 song objects' do 
      Songify.songs_repo.add_song(song)
      Songify.songs_repo.add_song(song2)
      result = Songify.songs_repo.view_all_songs

      expect(result).to be_an(Array)
      expect(result.length).to eq(2)
      expect(result[1].title).to eq("Kiss From a Rose")
    end
  end

  describe '#delete_song' do 
    it 'returns nil if no song matches id' do
      result = Songify.songs_repo.delete_song(1)
      expect(result).to be_nil
    end

    it 'deletes from database' do
      Songify.songs_repo.add_song(song)
      Songify.songs_repo.delete_song(1)

      result = Songify.songs_repo.view_song(1)
      expect(result).to be_nil
    end
  end

  describe '#delete_all' do
    it 'deletes everything from the table' do
      Songify.songs_repo.add_song(song)
      Songify.songs_repo.add_song(song2)
      Songify.songs_repo.delete_all

      result = Songify.songs_repo.view_song(1)
      expect(result).to be_nil
    end
  end
end