require_relative 'day01'

describe Traveler do
  let(:t) { Traveler.new }

  describe "move" do
    it "moves to the correct coordinates" do
      t.move "R1"

      expect(t.x).to eq 1
      expect(t.y).to eq 0
      expect(t.facing).to eq "east"

      t.move "R1"

      expect(t.x).to eq 1
      expect(t.y).to eq(-1)
      expect(t.facing).to eq "south"

      t.move "R1"

      expect(t.x).to eq(0)
      expect(t.y).to eq(-1)
      expect(t.facing).to eq "west"

      t.move "R1"

      expect(t.x).to eq(0)
      expect(t.y).to eq(0)
      expect(t.facing).to eq "north"

      t.move "L1"

      expect(t.x).to eq(-1)
      expect(t.y).to eq(0)
      expect(t.facing).to eq "west"

      t.move "L1"

      expect(t.x).to eq(-1)
      expect(t.y).to eq(-1)
      expect(t.facing).to eq "south"

      t.move "L1"

      expect(t.x).to eq(0)
      expect(t.y).to eq(-1)
      expect(t.facing).to eq "east"

      t.move "L1"

      expect(t.x).to eq(0)
      expect(t.y).to eq(0)
      expect(t.facing).to eq "north"
    end
  end

  describe 'follow_instructions' do
    it "puts you at correct destination" do
      instructions = %w[R2 L3]
      t.follow instructions
      expect(t.x).to eq 2
      expect(t.y).to eq 3
      expect(t.facing).to eq "north"
    end
  end

  describe 'calculate_distance' do
    it "calculates how many blocks from start" do
      instructions = %w[R2 L3]
      t.follow instructions
      expect(t.calculate_distance).to eq 5
    end

    it "calculates how many blocks from start" do
      instructions = %w[R2 R2 R2]
      t.follow instructions
      expect(t.calculate_distance).to eq 2
    end

    it "calculates how many blocks from start" do
      instructions = %w[R5 L5 R5 R3]
      t.follow instructions
      expect(t.calculate_distance).to eq 12
    end
  end
end
