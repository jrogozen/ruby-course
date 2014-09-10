require_relative '../app.rb'
require 'sinatra/base'
require 'sinatra/reloader'

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

  get '/find' do
    erb :find_song
  end

  get '/song' do
    puts params
    @song = Songify.songs_repo.view_song(params[:id])
    erb :view_song
  end

  get '/add' do
    erb :add_song
  end

  get '/delete' do 
    erb :delete_song
  end

  # post requests

  post '/add' do
    puts params
    id = Songify.songs_repo.save_song(Songify::Song.new({title: params[:title]}))
    @song = Songify.songs_repo.view_song(id)
    erb :submitted_song
  end

  # delete requests 

  run! if app_file == $0
end