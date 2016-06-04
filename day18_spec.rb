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
#.##.#
####.#
...##.
......
#...#.
#.####
GRID
  ).readlines.map do |line|
    line.strip.split("").map { |light| light == "#" }
  end
  }

  let(:output5) { StringIO.new(
<<GRID
##.###
.##..#
.##...
.##...
#.#...
##...#
GRID
  ).readlines.map do |line|
    line.strip.split("").map { |light| light == "#" }
  end
  }

  let(:display) { Display.new input }
  let(:grid) { display.grid }

  describe "count_lit" do
    it "counts number of lights on" do
      display.animate 5
      expect(display.count_lit).to eq 17
    end
  end

  describe "animate" do
    it "changes correctly after given number of steps" do
      display.animate 5
      expect(display.grid).to eq output5
    end
  end

  describe "change" do
    it "changes correctly" do
      display.change
      expect(display.grid).to eq output1
    end
  end

  describe 'lit_neighbors' do
    it 'works' do
      expect(display.lit_neighbors(0, 0)).to eq 1
      expect(display.lit_neighbors(5, 0)).to eq 2
    end
  end
end
