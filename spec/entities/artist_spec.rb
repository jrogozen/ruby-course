require_relative '../spec_helper.rb'

describe Songify::Artist do
  # songs

  # artist
  let(:weezer) do 
    Songify::Artist.new({
    :name => "Weezer"
    })
  end

  describe '#initialize' do 
    it 'initializes all parameters' do
    expect(weezer.name).to eq("Weezer")
    end
  end
end