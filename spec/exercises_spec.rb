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
	let (:result) {Exercises}

	it "puts name and occupation for single element" do
		result.should_receive(:puts).exactly(2).times
		result.ex8([{:name => 'Bob', :occupation => 'Builder'}])
	end

	it "puts correct times for multiple people" do
		result.should_receive(:puts).exactly(4).times
		result.ex8([{:name => 'Bob', :occupation => 'Builder'}, {:name => 'Jon', :occupation => 'Samurai'}])
	end
end

describe 'Exercise9' do
	it "return true if it is a leap year" do 
		expect(Exercises.ex9(1996)).to eq(true)
	end

	it "return false if it is not a leap year" do
		expect(Exercises.ex9(1995)).to eq(false)
	end

	it "return nil if it isn't an available year" do
		expect(Exercises.ex9(-1)).to eq(false)
	end
end

describe 'Exercise10' do
	context "it's happy hour" do
		it "return happy hour" do
			t = Time.new(2007, 8, 29, 16, 0, 0)
			#binding.pry
			allow(Time).to receive(:now).and_return(t)
			result = Exercises.ex10
			expect(result).to eq("happy hour")
		end
	end

	context "it's not happy hour" do 
		it "returns normal price" do
			t = Time.new(2007, 8, 29, 1, 0, 0)
			allow(Time).to receive(:now).and_return(t)
			result = Exercises.ex10
			expect(result).to eq("normal prices")
		end
	end
end

describe RPS do
	let(:game1) {RPS.new("joe", "shmoe")}
	let(:score) {game1.score}

	describe "#initialize" do
		it "should initialize the players" do
			expect(game1.p1).to eq("joe")
			expect(game1.p2).to eq("shmoe")
		end

		it "should set score equal to a zero, zero array" do
			expect(game1.score).to eq([0,0])
		end
	end 

	describe "#play" do
		it "should only return score on valid plays" do
			expect(game1.play("scissors", "x")).to be_nil
			expect(game1.play("scissors", "rock")).to eq(score)
		end

		it "should add score to correct person" do
			# simulate a move
			game1.play("rock", "scissors")
			expect(score).to eq([1,0])
			game1.play("scissors", "rock")
			expect(score).to eq([1,1])
		end

		it "should add up to 2 scores" do
			game1.play("rock", "scissors")
			game1.play("rock", "scissors")
			expect(score).to eq([2,0])
		end

		it "should return congrats after 2nd point" do
			game1.play("rock", "scissors")
			game1.should_receive(:puts).exactly(1).times
			game1.play("rock", "scissors")
		end

		it "should prevent people from playing after game is over" do
			game1.play("rock", "scissors")
			game1.play("rock", "scissors")
			game1.play("rock", "scissors")
			expect(score1).to eq([0,0])
		end

	end
end