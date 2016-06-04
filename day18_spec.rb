require_relative 'day18'

describe Display do
  let(:input) { StringIO.new(
<<INPUT
.#.#.#
...##.
#....#
..#...
#.#..#
####..
INPUT
  ).readlines }

  let(:output1) { StringIO.new(
<<GRID
..##..
..##.#
...##.
......
#.....
#.##..
GRID
  ).readlines.map { |x| x.strip! } }

  let(:output4) { StringIO.new(
<<GRID
......
......
..##..
..##..
......
......
GRID
  ).readlines.map { |x| x.strip! } }

  let(:display) { Display.new input }
  let(:grid) { display.grid }

  describe "count_lit" do
    it "counts number of lights on" do
      display.animate 4
      expect(display.count_lit).to eq 4
    end
  end

  describe "animate" do
    it "changes correctly after given number of steps" do
      display.animate 4
      expect(display.grid).to eq output4
    end
  end

  describe "change" do
    it "changes correctly" do
      display.change
      expect(display.grid).to eq output1
    end
  end

  describe 'lit_neighbors_count' do
    it 'works' do
      expect(display.lit_neighbors(0, 0)).to eq 1
      expect(display.lit_neighbors(5, 0)).to eq 2
    end
  end

  describe "find_neighbors" do
    it "returns list of neighbors if not an edge case" do
      expect(display.find_neighbors(1, 1).count).to eq 8
    end

    it "returns list of neighbors for left edge" do
      expect(display.find_neighbors(1, 5).count).to eq 5
    end

    it "returns list of neighbors for right edge" do
      expect(display.find_neighbors(1, 0).count).to eq 5
    end

    it "returns list of neighbors for top edge" do
      expect(display.find_neighbors(0, 1).count).to eq 5
    end

    it "returns list of neighbors for bottom edge" do
      expect(display.find_neighbors(5, 1).count).to eq 5
    end

    it "returns list of neighbors for top corners" do
      expect(display.find_neighbors(0, 0).count).to eq 3
      expect(display.find_neighbors(0, 5).count).to eq 3
    end

    it "returns list of neighbors for bottom corners" do
      expect(display.find_neighbors(5, 0).count).to eq 3
      expect(display.find_neighbors(5, 5).count).to eq 3
    end
  end
end
