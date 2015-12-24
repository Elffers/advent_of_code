require_relative 'day3'

describe Mapper do
  let(:mapper) { Mapper.new }
  describe "count_houses" do
    it "counts houses" do
      count = mapper.count_houses(">")
      expect(count).to eq 2
    end
    it "counts houses" do
      count = mapper.count_houses("^>v<")
      expect(count).to eq 4
    end
    it "counts houses" do
      count = mapper.count_houses("^v^v^v^v^v")
      expect(count).to eq 2
    end
  end
end
