require "./exercises.rb"
require 'pry-byebug'

describe 'Exercise0' do
	context "when string passed in" do
		it "triples the length of a string" do
			result = Exercises.ex0("ha")
			expect(result).to eq("hahaha")
		end
	end

	context "when invalid string is passed in" do
		it "returns 'nope' if the string is 'wishes'" do
			result = Exercises.ex0("wishes")
			expect(result).to eq("nope")
		end
	end
	context "when a string isn't passed in" do
		it "returns 'not a string' when non-string is passed in" do
			result = Exercises.ex0(12)
			expect(result).to eq("not a string")
		end
	end
end