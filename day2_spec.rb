require_relative 'day2'

describe WrapperCalculator do
  let(:wc) { WrapperCalculator.new('day2_input.txt') }

  describe "parse_dimensions" do
    it "returns an array of 3 integers" do
      dimensions = wc.parse_dimensions("20x4x5")
      expect(dimensions).to eq [20, 4, 5]
    end
  end

  describe "measure" do
    it "returns double the sum of all sides + smallest side" do
      total = wc.measure([2, 3, 4])
      expect(total).to eq 58
    end
  end
end
