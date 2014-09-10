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
  end

  # get requests

  get '/' do
    @songs = Songify.songs_repo.view_all_songs
    erb :index
  end

  get '/songs' do
    @songs = Songify.songs_repo.view_all_songs
    erb :index
  end

  get '/find' do
    erb :find_song
  end

  get '/song' do
    puts params

    # how to determine if it's an integer or string?
    if params[:value].to_i == 0
      query = params[:value]
    else
      query = params[:value].to_i
    end
    @song = Songify.songs_repo.view_song(query)
    erb :view_song
    
  end

  # new song (show form)
  get '/songs/new' do
    erb :add_song
  end

  # change rating
  get '/rating' do
    # puts params
    Songify.songs_repo.change_rating(params[:id], params[:rating])
    redirect '/'
  end

  # post requests

  # create song (accept form)
  post '/song' do
    puts params
    id = Songify.songs_repo.save_song(
      Songify::Song.new(
        {
          title: params[:title], 
          genre: Songify::Genre.new(name: params[:genre])
        }
      )
    )
    
    @song = Songify.songs_repo.view_song(id)
    erb :submitted_song
  end

  # delete requests


  run! if app_file == $0
end