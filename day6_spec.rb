require_relative 'day6'

describe Display do
  let(:lights) { Display.new }
  describe "parse instruction" do
    it "returns a pair of coordinates and action" do
      result = lights.parse_instruction "turn on 887,9 through 959,629"

      expect(result).to eq([[887, 9], [959, 629], :on])

      result = lights.parse_instruction "turn off 887,9 through 959,629"

      expect(result).to eq([[887, 9], [959, 629], :off])

      result = lights.parse_instruction "toggle 887,9 through 959,629"

      expect(result).to eq([[887, 9], [959, 629], :toggle])

      expect { lights.parse_instruction "foo 887,9 through 959,629" }.to raise_error RuntimeError

    end
  end

  describe "flip" do
    it "turns on lights" do
      lights.flip([0,0], [1, 1], :on)

      expect(lights.grid[0][0]).to eq "*"
      expect(lights.grid[1][0]).to eq "*"
      expect(lights.grid[0][1]).to eq "*"
      expect(lights.grid[1][1]).to eq "*"
    end

    it "turns off lights" do
      lights.flip([0,0], [1, 1], :on)
      lights.flip([0,0], [0, 1], :off)

      expect(lights.grid[0][0]).to eq " "
      expect(lights.grid[0][1]).to eq " "
      expect(lights.grid[1][0]).to eq "*"
      expect(lights.grid[1][1]).to eq "*"
    end

    it "toggles lights" do
      lights.flip([0,0], [1, 1], :on)
      lights.flip([0,0], [0, 1], :off)
      lights.flip([0,0], [1, 1], :toggle)

      expect(lights.grid[0][0]).to eq "*"
      expect(lights.grid[0][1]).to eq "*"
      expect(lights.grid[1][0]).to eq " "
      expect(lights.grid[1][1]).to eq " "
    end
  end

  describe "count_lights" do
    it "returns number of lights lit after all instructions" do
      lights.flip([0,0], [1, 1], :on)
      lights.flip([0,0], [0, 1], :off)
      lights.flip([0,0], [1, 1], :toggle)

      count = lights.count_lights
      expect(count).to eq 2
    end
  end
end

describe BrightnessDisplay do
  let(:lights) { BrightnessDisplay.new }
  describe "brightness" do
    it "returns total brightness" do
      lights.flip([0,0], [1, 1], :on)
      expect(lights.brightness).to eq 4
    end
  end

end
