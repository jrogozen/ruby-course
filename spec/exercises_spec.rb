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

describe 'Exercise1' do
	context "when array is passed in" do 
		it "returns size of 3 element array" do
			result = Exercises.ex1([1,2,3])
			expect(result).to eq(3)
		end
		it "returns size of 0 element array" do
			result = Exercises.ex1([])
			expect(result).to eq(0)
		end
 	end

 	context "when non-array is passed in" do
 		it "returns nil if non array is passed in" do
 			result = Exercises.ex1("not array")
 			expect(result).to be_nil
 		end
 	end
end