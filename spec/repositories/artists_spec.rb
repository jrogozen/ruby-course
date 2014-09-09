# require_relative '../spec_helper.rb'

# describe Songify::Repositories::Songs do
#   # songs
#   let(:song) do
#     Songify::Song.new({
#       title: "2 On",
#       artist: "Tinashe",
#       album: "Aquarius",
#       rating: 5
#       })
#   end
#   let (:song2) do
#     Songify::Song.new({
#       title: "Kiss From a Rose",
#       artist: "Seal",
#       genre: "Pop",
#       album: "Seal",
#       rating: 10
#       })
#   end

#   describe '#add_artist' do
#     it 'adds artist to the database' do
#       result = Songify.artists_repo.add_artist("Seal")
#       expect(result.first["id"].to_i).to eq(1)
#     end
#   end

#   describe '#check_for_artist' do 
#     it 'returns nil if artist is not in database' do
#       # takes string as argument
#       result = Songify.artists_repo.check_for_artist("Seal")
#       expect(result.first).to be_nil
#     end

#     it 'returns artist id if artist is in the database' do
#       Songify.artists_repo.add_artist("Seal")
#       result = Songify.artists_repo.check_for_artist("Seal")
#       expect(result.first["id"].to_i).to eq(1)
#     end
#   end
# end