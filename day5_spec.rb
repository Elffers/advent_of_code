require_relative 'day5'

describe SantaString do
  let(:s) { SantaString.new "aaa" }
  describe "nice?" do
    it "tells if a string is nice" do
      expect(s.nice?).to eq true
      s = SantaString.new "aba"
      expect(s.nice?).to eq false
      s = SantaString.new "adc"
      expect(s.nice?).to eq false
    end
  end

  describe "nice2?" do
    it "tells if a string is nice" do
      s = SantaString.new "qjhvhtzxzqqjkmpb"
      expect(s.nice2?).to eq true
      s = SantaString.new "xxyxx"
      expect(s.nice2?).to eq true
    end
  end

  describe "double_repeated?" do
    it "returns true if string has double repeated substring" do
      s = SantaString.new "xyxy"
      expect(s.double_repeated?).to be_truthy
      s = SantaString.new "aabcdefgaa"
      expect(s.double_repeated?).to be_truthy
    end
  end

  describe "has_spaced_double?" do
    it "returns true if string contains a repeated letter with one letter in between" do
      s = SantaString.new "xyx"
      expect(s.has_spaced_double?).to be_truthy
      s = SantaString.new "abcdefeghi"
      expect(s.has_spaced_double?).to be_truthy
      s = SantaString.new "aaa"
      expect(s.has_spaced_double?).to be_truthy
      s = SantaString.new "axyza"
      expect(s.has_spaced_double?).to be_falsey
    end
  end

  describe "count_vowels" do
    it "counts the number of the vowels in a string" do
      expect(s.count_vowels).to eq 3
    end
  end

  describe "has_repeated?" do
    it "returns true if letter in string appears twice in a row" do
      expect(s.has_repeated?).to be_truthy
    end
  end

  describe "has_prohibited?" do
    let(:s) { SantaString.new "aba" }
    it "returns true if letter in string contains prohibited substring" do
      expect(s.has_prohibited?).to be_truthy
    end
  end
end
