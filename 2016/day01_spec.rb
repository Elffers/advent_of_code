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
end
