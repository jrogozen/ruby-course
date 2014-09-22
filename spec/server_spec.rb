describe Songify::Server do

  def app
    Songify::Server.new
  end

  describe "GET /" do
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
        artists: [tinashe, seal],
        album: "Aquarius",
        genre: pop,
        lyrics: "I love to get too on."
        })
    end
    let (:song2) do
      Songify::Song.new({
        title: "Kiss From a Rose",
        artists: [seal, tinashe],
        genre: pop,
        album: "Seal",
        lyrics: "this rose is too on."
        })
    end

    it "loads the homepage" do
      Songify.songs_repo.save_song(song)
      Songify.songs_repo.save_song(song2)

      get '/'
      expect(last_response).to be_ok
      expect(last_response.body).to include "2 On", "Kiss From a Rose"
    end

    it "loads songs page" do
      Songify.songs_repo.save_song(song)
      Songify.songs_repo.save_song(song2)

      get '/songs'
      expect(last_response).to be_ok
      expect(last_response.body).to include "2 On", "Kiss From a Rose"
    end

    it "asks for song id" do 
      get '/find'
      expect(last_response).to be_ok
      expect(last_response.body).to include "Search"
    end

    it "shows song id after requested" do 
      Songify.songs_repo.save_song(song)

      get '/songs/1'
      expect(last_response).to be_ok
      expect(last_response.body).to include "1", "2 On"
    end

    it 'shows form to add a song' do
      get '/songs/new'
      expect(last_response).to be_ok
      expect(last_response.body).to include "Add Song"
    end
  end

  describe "DELETE /" do 
    xit 'deletes the song from the db' do 
    end
  end
end