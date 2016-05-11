require_relative 'day14'

describe Racer do
  let(:input) { StringIO.new(
    <<INPUT
Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.
Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds.
INPUT
  ) }
  let(:racer) { Racer.new input.readlines }

  describe 'parse' do
    it "creates store for reindeer" do
      racer.parse

      expected = {
        "Comet" => { speed: 14,
                     interval: 10,
                     rest: 127 },
        "Dancer" => { speed: 16,
                       interval: 11,
                       rest: 162 }
      }

      expect(racer.reindeer).to eq expected
    end
  end

  describe "distance" do
    it "returns correct distance travelled" do
      racer.parse
      expect(racer.distance 138, "Comet").to eq 154
      expect(racer.distance 1000, "Comet").to eq 1120
      expect(racer.distance 1000, "Dancer").to eq 1056
    end
  end

  describe "race" do
    it "returns distance of winner" do
      racer.parse
      expect(racer.race 1000).to eq 1120
    end
  end
end
