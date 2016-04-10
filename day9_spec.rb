require_relative 'day9'


describe "Router" do
  let(:input) { StringIO.new("London to Dublin = 464\nLondon to Belfast = 518\nDublin to Belfast = 141\n").readlines }
  let(:r) { Router.new(input) }

  describe "#parse" do
    it "returns hash of distances" do
      r.parse

      expected = {
        "London" => { "Dublin" => 464,
                      "Belfast" => 518 },
        "Dublin" => { "Belfast" => 141,
                      "London" => 464 },
        "Belfast" => { "Dublin" => 141,
                      "London" => 518}
      }

      expect(r.routes).to eq expected
      expect(r.cities.to_a).to eq ["London", "Dublin", "Belfast"]
    end
  end

  describe "#paths" do
    it "finds all paths" do
      r.parse
      expect(r.paths).to eq [605, 659, 982, 659, 982, 605]
    end
  end

  describe "#shortest_path" do
    it "returns shortest path" do
      expect(r.shortest_path).to eq 605
    end
  end
end
