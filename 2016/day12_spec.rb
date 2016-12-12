require_relative 'day12'

describe Assembler do
  let(:file) { StringIO.new(<<INPUT
cpy 41 a
inc a
inc a
dec a
jnz a 2
dec a
INPUT
                           ) }

  let(:input) { file.readlines.map { |x| x.strip } }
  let(:a) { Assembler.new }

  describe 'parse' do
    it 'works' do
      a.parse input
      p a.registers
      expect(a.registers["a"]).to eq 42
    end
  end
end
