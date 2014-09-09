# require_relative '../spec_helper.rb'

# describe Songify::Repositories::ArtistsSongs do
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

#   describe 'view_artist_id' do
#     # takes song id as an argument
#     xit 'returns artist id' do
#       Songify.songs_repo.add_song(song)
#       result = Songiy.artists_songs_repo.view_artist_id(1)
#       expect(result.first["artist_id"]).to eq(1)
#     end
#   end
# end