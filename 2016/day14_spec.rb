require_relative 'day14'

describe KeyGenerator do
  let(:kg) { KeyGenerator.new 'abc' }

  describe 'match?' do
    it 'returns true if there is a pentuple in next 1000 digests' do
      expect(kg.match? 39, 'e').to eq true
    end

    it 'returns false if there is not a pentuple in next 1000 digests' do
      expect(kg.match? 18, '8').to eq false
    end
  end
end
