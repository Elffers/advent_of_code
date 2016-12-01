require_relative "day4"

describe Stuffer do
  let(:s) { Stuffer.new }
  describe "hash_key" do
    it "returns lowest number whose md5 hash starts with five 0's" do
      key = "abcdef"
      expect(s.hash_key(key)).to eq 609043
      key2 = "pqrstuv"
      expect(s.hash_key(key2)).to eq 1048970
    end
  end
end
