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

  describe "check_last_four" do

    def execute
      t.instructions.each do |instr|
        t.move instr
        t.update_last_four instr
      end
    end

    it "returns false if not all dirs are the same" do
      t.parse %w[R8 R4 R4 L8]
      execute
      expect(t.check_last_four).to eq nil
    end

    it "returns nil if there is no intersection" do
      t.parse %w[R8 R4 R4 R2]
      execute
      expect(t.check_last_four).to eq nil
    end

    it "returns nil if there is no intersection" do
      t.parse %w[R1 R3 R5 R5]
      execute
      expect(t.check_last_four).to eq nil
    end

    it "returns nil if there is no intersection" do
      t.parse %w[L1 L3 L3 L5]
      execute
      expect(t.check_last_four).to eq nil
    end

    it "returns true if there is an intersection" do
      t.parse %w[R8 R4 R4 R8]
      execute
      expect(t.check_last_four).to eq 4
    end

    it "returns true if there is an intersection" do
      t.parse  %w[L8 L4 L6 L4]
      execute
      expect(t.check_last_four).to eq 0
    end
  end

  describe "find_visited" do
    it "finds distance from first visited" do
      t.parse %w[R8 R4 R4 R8]
      expect(t.find_visited).to eq 4
      expect(t.facing).to eq "north"
    end

    it "finds distance from first visited" do
      t.parse %w[L1 R8 R4 R4 R8]
      expect(t.find_visited).to eq 5
      expect(t.facing).to eq "west"
    end

    it "finds distance from first visited" do
      t.parse %w[L1 L2 L8 R4 R4 R8]
      expect(t.find_visited).to eq 5
      expect(t.facing).to eq "north"
    end

    it "finds distance from first visited" do
      t.parse %w[R1 L1 R1 R1 L1 L1 R1 R1 R1 R1]
      expect(t.find_visited).to eq 3
      expect(t.facing).to eq "west"
    end

    it "finds distance from first visited" do
      t.parse %w[R1 L1 R1 R1 L1 L1 R1 L1 L1 L1]
      expect(t.find_visited).to eq 4
      expect(t.facing).to eq "south"
    end

    it "finds distance from first visited" do
      t.parse %w[R6 R6 R5 R2 R4 L2 L4 R3]
      # does not cross until after the most recent 4
      expect(t.find_visited).to eq 2
      expect(t.facing).to eq "north"
    end

    xit "finds distance from first visited" do
      t.parse %w[R2 L5 L4 L5 R4 R1 L4 R5 R3 R1 L1 L1 R4 L4 L1 R4 L4 R4 L3 R5 R4 R1 R3 L1 L1 R1 L2 R5 L4 L3 R1 L2 L2 R192 L3 R5 R48 R5 L2 R76 R4 R2 R1 L1 L5 L1 R185 L5 L1 R5 L4 R1 R3 L4 L3 R1 L5 R4 L4 R4 R5 L3 L1 L2 L4 L3 L4 R2 R2 L3 L5 R2 R5 L1 R1 L3 L5 L3 R4 L4 R3 L1 R5 L3 R2 R4 R2 L1 R3 L1 L3 L5 R4 R5 R2 R2 L5 L3 L1 L1 L5 L2 L3 R3 R3 L3 L4 L5 R2 L1 R1 R3 R4 L2 R1 L1 R3 R3 L4 L2 R5 R5 L1 R4 L5 L5 R1 L5 R4 R2 L1 L4 R1 L1 L1 L5 R3 R4 L2 R1 R2 R1 R1 R3 L5 R1 R4]
      t.find_visited
      # expect(t.find_visited).to eq 5
      expect(t.facing).to eq "north"
    end
  end

end
