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

  describe "count_vowels" do
    it "counts the number of the vowels in a string" do
      expect(s.count_vowels).to eq 3
    end
  end

  describe "has_double?" do
    it "returns true if letter in string appears twice in a row" do
      expect(s.has_double?).to be_truthy
    end
  end

  describe "has_prohibited?" do
    let(:s) { SantaString.new "aba" }
    it "returns true if letter in string contains prohibited substring" do
      expect(s.has_prohibited?).to be_truthy
    end
  end
end
