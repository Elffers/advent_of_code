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

  describe "peek_four" do
    it "returns false if not all dirs are the same" do
      t.parse %w[R8 R4 R4 L8]
      expect(t.peek_four t.instructions).to eq nil
    end

    it "returns nil if there is no intersection" do
      t.parse %w[R8 R4 R4 R2]
      expect(t.peek_four t.instructions).to eq nil
    end

    it "returns nil if there is no intersection" do
      t.parse %w[R1 R3 R5 R5]
      expect(t.peek_four t.instructions).to eq nil
    end

    it "returns nil if there is no intersection" do
      t.parse %w[L1 L3 L3 L5]
      expect(t.peek_four t.instructions).to eq nil
    end

    it "returns true if there is an intersection" do
      t.parse %w[R8 R4 R4 R8]
      actual = t.peek_four t.instructions
      expect(actual.map(&:to_s)).to eq %w[R8 R4 R4 R4]
    end

    it "returns true if there is an intersection" do
      t.parse  %w[L8 L4 L6 L4]
      actual = t.peek_four t.instructions
      expect(actual.map(&:to_s)).to eq %w[L8 L4 L6 L4]
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
      p [t.x, t.y]
      expect(t.facing).to eq "north"
    end
  end

end
