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

    # songs
    let(:song) do
      Songify::Song.new({
        title: "2 On",
        artist: "Tinashe",
        album: "Aquarius",
        genre: pop
        })
    end
    let (:song2) do
      Songify::Song.new({
        title: "Kiss From a Rose",
        artist: "Seal",
        genre: pop,
        album: "Seal",
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

  describe "POST /" do 
    it 'shows the added song' do
      post '/song', {:title => 'Kiss From a Rose', :genre => "Pop"} 
      expect(last_response).to be_ok
      expect(last_response.body).to include "Kiss From a Rose", "added song"
    end
  end

  describe "DELETE /" do 
    xit 'deletes the song from the db' do 
    end
  end
end