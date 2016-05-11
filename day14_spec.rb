require_relative 'day14'

describe Racer do
  let(:input) { StringIO.new(
    <<INPUT
Vixen can fly 8 km/s for 8 seconds, but then must rest for 53 seconds.
Blitzen can fly 13 km/s for 4 seconds, but then must rest for 49 seconds.
INPUT
  ) }
  let(:racer) { Racer.new input.readlines }

  describe 'parse' do
    it "creates store for reindeer" do
      racer.parse

      expected = {
        "Vixen" => { speed: 8,
                     time: 8,
                     rest: 53 },
        "Blitzen" => { speed: 13,
                       time: 4,
                       rest: 49 }
      }

      expect(racer.reindeer).to eq expected
    end
  end
end
