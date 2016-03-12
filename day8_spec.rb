require_relative 'day8'

describe Matchstick do
  let(:m) { Matchstick.new }
  let(:empty_string) { '""' }
  let(:normal_string) { '"abc"' }
  let(:string_with_escape_chars) { '"aaa\\"aaa"' }
  let(:string_with_hex_escape) { '"\\x27"' }
  let(:str1) { '"x\"\xcaj\\xwwvpdldz"' }
  let(:str2) { '"\"ubgxxcvnltzaucrzg\\\\xcez\"\n"' }

  describe "#total_chars" do
    it "returns the total number of characters" do
      expect(m.total_chars empty_string).to eq 2
      expect(m.total_chars normal_string).to eq 5
      expect(m.total_chars string_with_escape_chars).to eq 10
      expect(m.total_chars string_with_hex_escape).to eq 6
      expect(m.total_chars str1).to eq 20
    end
  end

  describe "#length" do
    it "returns correct length" do
      expect(m.length empty_string).to eq 0
      expect(m.length normal_string).to eq 3
      expect(m.length string_with_escape_chars).to eq 7
      expect(m.length string_with_hex_escape).to eq 1
      expect(m.length '"\x27\x27"').to eq 2
      expect(m.length '"\x27\\"\\\"').to eq 3
      expect(m.length str1).to eq 14
      expect(m.length str2).to eq 26
    end
  end

  describe "#diff" do
    it "returns the difference in total length and length" do
      expect(m.diff empty_string).to eq 2
      expect(m.diff normal_string).to eq 2
      expect(m.diff string_with_escape_chars).to eq 3
      expect(m.diff string_with_hex_escape).to eq 5
    end
  end

  describe "#find_diff" do
    it "returns the diff" do
      expect(m.find_diff "day8_test_input.txt").to eq 12
    end
  end

end
