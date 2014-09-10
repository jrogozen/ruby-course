describe Songify::Server do

  def app
    Songify::Server.new
  end

  describe "GET /" do
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


    it "loads the homepage" do
      Songify.songs_repo.save_song(song)
      Songify.songs_repo.save_song(song2)

      get '/'
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

      get '/song', {:id => 1}
      expect(last_response).to be_ok
      expect(last_response.body).to include "1", "2 On"
    end

    it 'shows form to add a song' do
      get '/add'
      expect(last_response).to be_ok
      expect(last_response.body).to include "Add Song"
    end

    xit 'shows form to request song' do 
      get '/delete'
      expect(last_response).to be_ok
      expect(last_response.body).to include "Delete Song"
    end

  end

  describe "POST /" do 
    it 'shows the added song' do
      post '/add', {:title => 'Kiss From a Rose'} 
      expect(last_response).to be_ok
      expect(last_response.body).to include "Kiss From a Rose", "added song"
    end
  end
end