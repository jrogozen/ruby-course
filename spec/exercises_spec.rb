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
		it "returns 'not a string'" do
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
 		it "returns nil" do
 			result = Exercises.ex1("not array")
 			expect(result).to be_nil
 		end
 	end
end

describe 'Exercise2' do
	context "when array is passed in" do
		it "returns second element of 4 element array" do
			result = Exercises.ex2([1,2,3,4])
			expect(result).to eq(2)
		end

		it "returns nil for a one element array" do
			result = Exercises.ex2([1])
			expect(result).to be_nil
		end
	end

	context "when non-array is passed in" do
		it "returns nil" do
			result = Exercises.ex2(21)
			expect(result).to be_nil
		end
	end
end

describe 'Exercise3' do
	it "returns nil if empty array" do
		result = Exercises.ex3([])
		expect(result).to be_nil
	end

	it "returns correct sum" do
		result = Exercises.ex3([1,2,3])
		expect(result).to eq(6)
	end

	it "works with negative numbers in array" do
		result = Exercises.ex3([0,1,-2])
		expect(result).to eq(-1)
	end
end

describe 'Exercise4' do 
	it "returns nil if empty array" do
		result = Exercises.ex4([])
		expect(result).to be_nil
	end

	it "returns max number when positive" do
		result = Exercises.ex4([1,0,4,1])
		expect(result).to eq(4)
	end

	it "returns max number even if it's negative" do
		result = Exercises.ex4([-4,-200,-3,-1])
		expect(result).to eq(-1)
	end
end

describe 'Exercise5' do
	let(:result) { Exercises }

	it "should return 'hello'" do
		result.should_receive(:puts).and_return("hello")
		result.ex5(["hello"])
	end

	it "should return multiple puts statements" do
		result.should_receive(:puts).and_return("hello", "world")
		result.ex5(["hello", "world"])
	end
end

describe 'Exercise6' do
	context "last item in the array is not panda" do
		it "changes last item to panda" do
			result = Exercises.ex6(["my","name","is","jon"])
			expect(result[-1]).to eq("panda")
			expect(result.length).to eq(4)
		end
	end

	context "last item in the array is panda" do
		it "update last item to GODZILLA" do
			result = Exercises.ex6(["i","love","panda"])
			expect(result[-1]).to eq("GODZILLA")
			expect(result.length).to eq(3)
		end
	end
end

describe 'Exercise7' do
	context "'str' exists in the array" do
		let (:result) {Exercises.ex7([1,3,"str",100], "str")}
		it "should add 'str' to end of the array" do
			expect(result[-1]).to eq("str")
			expect(result.length).to eq(5)
		end
	end

	context "'str' does not exist in the array" do
		it "should NOT add str to the end of the array" do
			result = Exercises.ex7([1,2,3], "str")
			expect(result[-1]).to eq(3)
			expect(result.length).to eq(3)
		end
	end
end

describe 'Exercise8' do
end