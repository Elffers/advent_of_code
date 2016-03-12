require_relative 'day8'

describe Matchstick do
  let(:m) { Matchstick.new }
  let(:empty_string) { '""' }
  let(:normal_string) { '"abc"' }
  let(:string_with_escape_chars) { '"aaa\\"aaa"' }
  let(:string_with_hex_escape) { '"\\x27"' }

  describe "#total_chars" do
    it "returns the total number of characters for empty strings" do
      expect(m.total_chars empty_string).to eq 2
    end

    it "returns the total number of characters for strings with no escaped characters" do
      expect(m.total_chars normal_string).to eq 5
    end

    it "returns the total number of characters for strings with escaped characters" do
      expect(m.total_chars string_with_escape_chars).to eq 10
    end

    it "returns the total number of characters for strings with escaped characters" do
      expect(m.total_chars string_with_hex_escape).to eq 6
    end
  end
end
