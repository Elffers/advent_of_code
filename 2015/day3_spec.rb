require_relative 'day3'

describe Santa do
  let(:santa) { Santa.new }

  describe "coordinates" do
    it "starts at [0, 0]" do
      expect(santa.coordinates).to eq [0, 0]
    end
  end

  describe "movement" do
    it "moves north" do
      santa.move_north
      expect(santa.coordinates).to eq [-1, 0]
    end

    it "moves south" do
      santa.move_south
      expect(santa.coordinates).to eq [1, 0]
    end

    it "moves west" do
      santa.move_west
      expect(santa.coordinates).to eq [0, -1]
    end

    it "moves east" do
      santa.move_east
      expect(santa.coordinates).to eq [0, 1]
    end
  end
end

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

describe RoboMapper do
  let(:mapper) { RoboMapper.new }
  describe "count_houses" do
    it "counts houses" do
      count = mapper.count_houses("^v")
      expect(count).to eq 3
    end
    it "counts houses" do
      count = mapper.count_houses("^>v<")
      expect(count).to eq 3
    end
    it "counts houses" do
      count = mapper.count_houses("^v^v^v^v^v")
      expect(count).to eq 11
    end
  end
end
