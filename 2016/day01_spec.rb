require_relative 'day01'

describe Traveler do
  let(:t) { Traveler.new }

  describe "move" do
    it "moves to the correct coordinates" do
      instruction = Traveler::Instruction.new("R", 1)

      t.move instruction

      expect(t.x).to eq 1
      expect(t.y).to eq 0
      expect(t.facing).to eq "east"

      t.move instruction

      expect(t.x).to eq 1
      expect(t.y).to eq(-1)
      expect(t.facing).to eq "south"

      t.move instruction

      expect(t.x).to eq(0)
      expect(t.y).to eq(-1)
      expect(t.facing).to eq "west"

      t.move instruction

      expect(t.x).to eq(0)
      expect(t.y).to eq(0)
      expect(t.facing).to eq "north"

      instruction = Traveler::Instruction.new("L", 1)
      t.move instruction

      expect(t.x).to eq(-1)
      expect(t.y).to eq(0)
      expect(t.facing).to eq "west"

      t.move instruction

      expect(t.x).to eq(-1)
      expect(t.y).to eq(-1)
      expect(t.facing).to eq "south"

      t.move instruction

      expect(t.x).to eq(0)
      expect(t.y).to eq(-1)
      expect(t.facing).to eq "east"

      t.move instruction

      expect(t.x).to eq(0)
      expect(t.y).to eq(0)
      expect(t.facing).to eq "north"
    end
  end

  describe 'follow_instructions' do
    it "puts you at correct destination" do
      t.parse %w[R2 L3]
      t.follow_instructions
      expect(t.x).to eq 2
      expect(t.y).to eq 3
      expect(t.facing).to eq "north"
    end
  end

  describe 'calculate_distance' do
    it "calculates how many blocks from start" do
      t.parse %w[R2 L3]
      t.follow_instructions
      expect(t.calculate_distance).to eq 5
    end

    it "calculates how many blocks from start" do
      t.parse %w[R2 R2 R2]
      t.follow_instructions
      expect(t.calculate_distance).to eq 2
    end

    it "calculates how many blocks from start" do
      t.parse %w[R5 L5 R5 R3]
      t.follow_instructions
      expect(t.calculate_distance).to eq 12
    end
  end

  describe "mark_visited" do
    it "updates visited grid with all coords between start and stop, inclusive" do
      start = [0, 0]
      stop = [0, 3]

      t.mark_visited(start, stop)

      expect(t.visited[0][0]).to eq true
      expect(t.visited[0][1]).to eq true
      expect(t.visited[0][2]).to eq true
      expect(t.visited[0][3]).to eq true
    end

    it "updates visited grid with all coords between start and stop, inclusive" do
      start = [0, -2]
      stop = [3, -2]

      t.mark_visited(start, stop)

      expect(t.visited[0][-2]).to eq true
      expect(t.visited[1][-2]).to eq true
      expect(t.visited[2][-2]).to eq true
      expect(t.visited[3][-2]).to eq true
    end
  end

  describe "find_visited" do
    it "finds distance from first visited" do
      t.parse %w[R8 R4 R4 R8]
      t.find_visited

      expect(t.x).to eq 4
      expect(t.y).to eq 0
      expect(t.calculate_distance).to eq 4
      expect(t.facing).to eq "north"
    end

    it "finds distance from first visited" do
      t.parse %w[L1 R8 R4 R4 R8]
      t.find_visited

      expect(t.x).to eq -1
      expect(t.y).to eq 4
      expect(t.calculate_distance).to eq 5
      expect(t.facing).to eq "west"
    end

    it "finds distance from first visited" do
      t.parse %w[L1 L2 L8 R4 R4 R8]
      t.find_visited

      expect(t.x).to eq 3
      expect(t.y).to eq(-2)
      expect(t.calculate_distance).to eq 5
      expect(t.facing).to eq "north"
    end

    it "finds distance from first visited" do
      t.parse %w[R1 L1 R1 R1 L1 L1 R1 R1 R1 R1]
      t.find_visited

      expect(t.x).to eq 3
      expect(t.y).to eq 0
      expect(t.calculate_distance).to eq 3
      expect(t.facing).to eq "west"
    end

    it "finds distance from first visited" do
      t.parse %w[R1 L1 R1 R1 L1 L1 R1 L1 L1 L1]
      t.find_visited

      expect(t.x).to eq 3
      expect(t.y).to eq 1
      expect(t.calculate_distance).to eq 4
      expect(t.facing).to eq "south"
    end

    it "finds distance from first visited" do
      t.parse %w[R6 R6 R5 R2 R4 L2 L4 R3]
      # does not cross until after the most recent 4
      t.find_visited

      expect(t.x).to eq 1
      expect(t.y).to eq 0
      expect(t.calculate_distance).to eq 1
      expect(t.facing).to eq "north"
    end

    it "finds distance from first visited" do
      t.parse %w[R2 L5 L4 L5 R4 R1 L4 R5 R3 R1 L1 L1 R4 L4 L1 R4 L4 R4 L3 R5 R4 R1 R3 L1 L1 R1 L2 R5 L4 L3 R1 L2 L2 R192 L3 R5 R48 R5 L2 R76 R4 R2 R1 L1 L5 L1 R185 L5 L1 R5 L4 R1 R3 L4 L3 R1 L5 R4 L4 R4 R5 L3 L1 L2 L4 L3 L4 R2 R2 L3 L5 R2 R5 L1 R1 L3 L5 L3 R4 L4 R3 L1 R5 L3 R2 R4 R2 L1 R3 L1 L3 L5 R4 R5 R2 R2 L5 L3 L1 L1 L5 L2 L3 R3 R3 L3 L4 L5 R2 L1 R1 R3 R4 L2 R1 L1 R3 R3 L4 L2 R5 R5 L1 R4 L5 L5 R1 L5 R4 R2 L1 L4 R1 L1 L1 L5 R3 R4 L2 R1 R2 R1 R1 R3 L5 R1 R4]
      t.find_visited

      expect(t.x).to eq -3
      expect(t.y).to eq 138
      expect(t.calculate_distance).to eq 141
      expect(t.facing).to eq "west"
    end
  end

end
