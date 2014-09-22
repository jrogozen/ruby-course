require_relative '../app.rb'
require 'rspec'
require 'pry-byebug'
require './web/server.rb'
require 'rack/test'
require 'sinatra'

Rspec.configure do |config|
  config.before(:each) {reset_tables}
  config.before(:each) {create_tables}
  config.include Rack::Test::Methods
end

def reset_tables
  Songify::Repositories::drop_tables
end

def create_tables
  Songify::Repositories::create_tables
end