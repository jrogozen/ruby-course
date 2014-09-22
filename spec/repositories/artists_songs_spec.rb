require_relative '../spec_helper.rb'

describe Songify::Repositories::ArtistsSongs do
  # genre
  let(:pop) do 
    Songify::Genre.new({
    :name => "Pop"
    })
  end

  # artist
  let(:tinashe) do 
    Songify::Artist.new({
      :name => 'Tinashe'
    })
  end

  let (:seal) do 
    Songify::Artist.new({
        :name => "Seal"
    })
  end

  # songs
  let(:song) do
    Songify::Song.new({
      title: "2 On",
      artists: [tinashe],
      album: "Aquarius",
      genre: pop,
      lyrics: "I love to get too on."
      })
  end
  let (:song2) do
    Songify::Song.new({
      title: "Kiss From a Rose",
      artists: [seal],
      genre: pop,
      album: "Seal",
      lyrics: "this rose is too on."
      })
  end

  describe '#view_artists' do
    it 'returns array of artist objects' do 

    end 
  end
end