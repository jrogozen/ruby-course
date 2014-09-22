require_relative '../spec_helper.rb'

describe Songify::Genre do
  # songs

  # genre
  let(:pop) do 
    Songify::Genre.new({
    :name => "Pop"
    })
  end

  describe '#initialize' do 
    it 'initializes all parameters' do
    expect(pop.name).to eq("Pop")
    end
  end
end