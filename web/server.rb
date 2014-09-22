require_relative '../app.rb'
require 'sinatra/base'
require 'sinatra/reloader'
require 'pry-byebug'

class Songify::Server < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  configure do
    set :bind, '0.0.0.0.'
    set :static, true
    set :public_folder, 'public'
    enable :method_override
  end

  # get requests

  get '/' do
    puts params #=> {:sort => 'rating'}

    sort = params[:sort]

    if sort == "rating" || sort.nil?
      @songs = Songify.songs_repo.sort_songs_by_rating
    elsif sort == 'title'
      @songs = Songify.songs_repo.sort_songs_by_title
    elsif sort == 'genre'
      @songs = Songify.songs_repo.sort_songs_by_genre
    end

    erb :index
  end

  get '/songs/?' do
    @songs = Songify.songs_repo.view_all_songs
    erb :index
  end

  get '/find/?' do
    erb :find_song
  end

  get '/results' do
    puts params

    # how to determine if it's an integer or string?
    if params[:value].to_i == 0
      query = params[:value]
    else
      query = params[:value].to_i
    end

    @song = Songify.songs_repo.view_song(query)
    @artists = []
    @song.artists.each {|artist| @artists << artist.name}

    erb :view_song
  end

  # new song (show form)
  get '/songs/new' do
    @genres = Songify.genres_repo.all_genres
    erb :add_song
  end

  get '/songs/:id' do 
    @song = Songify.songs_repo.view_song(params[:id].to_i)
    @artists = []
    @song.artists.each {|artist| @artists << artist.name}
    erb :view_song
  end

  # change rating
  get '/rating' do
    # puts params
    Songify.songs_repo.change_rating(params[:id], params[:rating])
    redirect '/'
  end

  # create song (accept form)
  post '/song' do
    puts params
    song = Songify::Song.new(
        {
          title: params[:title], 
          genre: Songify::Genre.new(name: params[:genre]),
          lyrics: params[:lyrics],
          artists: []
        }
    )
    params[:artist].each do |artist|
      song.artists << Songify::Artist.new({:name => artist})
    end

    id = Songify.songs_repo.save_song(song)

    @song = Songify.songs_repo.view_song(id)
    erb :submitted_song
  end

  # edit song (show form)
  get '/songs/:id/edit' do
    @genres = Songify.genres_repo.all_genres
    @song = Songify.songs_repo.view_song(params[:id].to_i) 
    erb :edit_song
  end

  # edit song (completed)
  put '/songs/:id/edit' do
    puts params
    song = Songify::Song.new({
      :id => params[:id].to_i,
      :title => params[:title],
      :rating => params[:rating].to_i,
      :genre => Songify::Genre.new(name: params["genre"], id: params["genre_id"]),
      :lyrics => params[:lyrics],
      :artists => []
      })

    params[:artist].each do |artist|
      song.artists << Songify::Artist.new({:name => artist})
    end
    Songify.artists_songs_repo.delete_artist(song.id)
    Songify.songs_repo.save_song(song)
    redirect '/'
  end

  # search songs by lyrics
  get '/lyrics/?' do 
    erb :find_lyrics
  end

  get '/lyrics/results/?' do 
    puts params #{:lyrics => "string"}
    @songs = Songify.songs_repo.search_lyrics(params[:lyrics])
    erb :show_lyrics
  end



  # delete songs
  delete '/songs/:id' do 
    puts params
    Songify.songs_repo.delete_song(params[:id].to_i)
    redirect '/'
  end

  # show all genres
  get '/genres/?' do 
    @genres = Songify.genres_repo.all_genres
    erb :genres
  end

  # add genre (form)
  get '/genres/new' do
    erb :new_genre_form
  end

  # create genre (success)
  post '/genres' do
    puts params # {:name => "name"}

    id = Songify.genres_repo.add_genre(
      Songify::Genre.new(
        {
          name: params[:name], 
        }
      )
    )

    if id.nil?
      redirect '/'
    end

    @genre = Songify.genres_repo.view_genre(id)
    erb :added_genre
  end

  # show specific genre
  get '/genres/:id' do
    @genre = Songify.genres_repo.view_genre(params[:id].to_i)
    erb :genre
  end

  # update genre
  get '/genres/:id/edit' do
    @genre = Songify.genres_repo.view_genre(params[:id].to_i)
    erb :edit_genre
  end

  put '/genres/:id' do
    genre = Songify::Genre.new({
      :name => params[:name],
      :id => params[:id]
    }) 
    Songify.genres_repo.add_genre(genre)
    redirect '/'
  end

  # delete genre
  delete 'genres/:id' do 
    Songify.genres_repo.delete_genre(params[:id].to_i)
    redirect '/'
  end


  run! if app_file == $0
end