require_relative 'day02'

describe Decoder do
  let(:input) { StringIO.new(<<INPUT
ULL
RRDDD
LURDL
UUUUD
INPUT
                            ).readlines
  }

  describe 'part 1' do
    let(:d) { Decoder.new Decoder::KEYPAD}

    describe 'decode' do
      it "returns correct ending key" do
        instr = "ULL".chars
        start = [1, 1]

        expect(d.decode(start, instr)).to eq [0, 0]
      end

      it "returns correct ending key" do
        instr = "RRDDD".chars
        start = [0, 0]

        expect(d.decode(start, instr)).to eq [2, 2]
      end

      it "returns correct ending key" do
        instr = "LURDL".chars
        start = [2, 2]

        expect(d.decode(start, instr)).to eq [2, 1]
      end

      it "returns correct ending key" do
        instr = "UUUUD".chars
        start = [2, 1]

        expect(d.decode(start, instr)).to eq [1, 1]
      end
    end

    describe 'find_code' do
      it 'finds code' do
        d.parse input
        start = [1, 1]
        expect(d.find_code start).to eq '1985'
      end
    end
  end

  describe 'part 2' do
    let(:d) { Decoder.new Decoder::FANCY_KEYPAD}

    describe 'decode' do
      it "returns correct ending key" do
        instr = "ULL".chars
        start = [2, 0]

        expect(d.decode(start, instr)).to eq [2, 0]
      end

      it "returns correct ending key" do
        instr = "RRDDD".chars
        start = [2, 0]

        expect(d.decode(start, instr)).to eq [4, 2]
      end

      it "returns correct ending key" do
        instr = "LURDL".chars
        start = [4, 2]

        expect(d.decode(start, instr)).to eq [3, 2]
      end

      it "returns correct ending key" do
        instr = "UUUUD".chars
        start = [3, 2]

        expect(d.decode(start, instr)).to eq [1, 2]
      end

      it "returns correct ending key" do
        instr = "RRRRRRRRRRRLUUUUUUU".chars
        start = [2, 0]

        expect(d.decode(start, instr)).to eq [1, 3]
      end
    end

    describe 'find_code' do
      it 'finds code' do
        d.parse input
        start = [2, 0]
        expect(d.find_code start).to eq '5DB3'
      end
    end
  end
end
