require_relative '../spec_helper.rb'

describe Songify::Song do
  # songs
  let(:song) do
    Songify::Song.new({
      title: "2 On",
      artist: ["Tinashe"],
      genre: "Pop",
      album: "Aquarius",
      lyrics: "Disregard wenches, acquire currency."
      })
  end

  describe '#initialize' do 
    it 'initializes all parameters' do
      expect(song.title).to eq("2 On")
    end

    it 'initializes lyrics' do 
      expect(song.lyrics).to eq("Disregard wenches, acquire currency.")
    end
  end
end