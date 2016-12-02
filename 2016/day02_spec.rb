require_relative 'day02'

describe Decoder do
  let(:d) { Decoder.new }
  let(:input) { StringIO.new(<<INPUT
ULL
RRDDD
LURDL
UUUUD
INPUT
                            ).readlines
  }

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
    it 'finds code' do
      d.parse input
      expect(d.find_code).to eq '1985'
    end
  end

  describe 'decode2' do
    it "returns correct ending key" do
      instr = "ULL".chars
      start = '5'

      expect(d.decode2(start, instr)).to eq '5'
    end

    it "returns correct ending key" do

      instr = "RRDDD".chars
      start = '5'

      expect(d.decode2(start, instr)).to eq 'D'
    end

    it "returns correct ending key" do

      instr = "LURDL".chars
      start = "D"

      expect(d.decode2(start, instr)).to eq 'B'
    end

    it "returns correct ending key" do

      instr = "UUUUD".chars
      start = "B"

      expect(d.decode2(start, instr)).to eq '3'
    end

    it "returns correct ending key" do

      instr = "RRRRRRRRRRRLUUUUUUU".chars
      start = "5"

      expect(d.decode2(start, instr)).to eq '4'
    end
  end

  describe 'find_code2' do
    it 'finds code' do
      d.parse input
      expect(d.find_code2).to eq '5DB3'
    end
  end
end
