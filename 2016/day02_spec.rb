require_relative 'day02'

describe Decoder do
  let(:d) { Decoder.new }
  describe 'decode' do
    it "returns correct ending key" do
      instr = "ULL".chars
      start = 5

      expect(d.decode(start, instr)).to eq 1
    end

    it "returns correct ending key" do

      instr = "RRDDD".chars
      start = 1

      expect(d.decode(start, instr)).to eq 9
    end

    it "returns correct ending key" do

      instr = "LURDL".chars
      start = 9

      expect(d.decode(start, instr)).to eq 8
    end

    it "returns correct ending key" do

      instr = "UUUUD".chars
      start = 8

      expect(d.decode(start, instr)).to eq 5
    end
  end

  describe 'find_code' do
    let(:input) { StringIO.new(<<INPUT
ULL
RRDDD
LURDL
UUUUD
INPUT
                              ).readlines
    }

    it 'finds code' do
      d.parse input
      expect(d.find_code).to eq '1985'
    end
  end
end
