require_relative '../app.rb'
require 'rspec'
require 'pry-byebug'

Rspec.configure do |config|
  config.before(:each) {reset_tables}
  config.before(:each) {create_tables}
end

def reset_tables
  Songify::Repositories::drop_tables
end

def create_tables
  Songify::Repositories::create_tables
end