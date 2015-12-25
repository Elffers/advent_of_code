require_relative 'day2'

describe GiftWrapper do
  let(:wc) { GiftWrapper.new('day2_input.txt') }

  describe "parse_dimensions" do
    it "returns an array of 3 integers" do
      dimensions = wc.parse_dimensions("20x4x5")
      expect(dimensions).to eq [20, 4, 5]
    end
  end

  describe "calculate_paper" do
    it "returns total amount of gift wrap paper needed" do
      total = wc.calculate_paper([2, 3, 4])
      expect(total).to eq 58
    end
  end

  describe "cut_ribbon" do
    it "returns the length of ribbon needed" do
      total = wc.cut_ribbon([2, 3, 4])
      expect(total).to eq 34
    end
  end
end
