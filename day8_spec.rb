require_relative 'day8'

describe Matchstick do
  let(:m) { Matchstick.new }
  describe "#total_chars" do
    it "returns the total number of characters for empty strings" do
      expect(m.total_chars '""').to eq 2
    end

    it "returns the total number of characters for strings with no escaped characters" do
      expect(m.total_chars '"abc"').to eq 5
    end

    it "returns the total number of characters for strings with escaped characters" do
      expect(m.total_chars '"aaa\\"aaa"').to eq 10
    end

    it "returns the total number of characters for strings with escaped characters" do
      expect(m.total_chars '"\\x27"').to eq 6
    end
  end
end
