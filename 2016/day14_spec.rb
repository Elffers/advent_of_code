require_relative 'day14'

describe KeyGenerator do
  let(:kg) { KeyGenerator.new 'abc' }

  describe 'match?' do
    it 'returns true if there is a pentuple in next 1000 digests' do
      expect(kg.match? 39, 'e').to eq true
    end

    it 'returns true if there is a pentuple in next 1000 digests' do
      expect(kg.match? 10, 'e').to eq true
    end

    it 'returns true if there is a pentuple in next 1000 digests' do
      expect(kg.match? 22551, 'f').to eq true
    end

    it 'returns false if there is not a pentuple in next 1000 digests' do
      expect(kg.match? 18, '8').to eq false
    end

    it 'returns false if there is not a pentuple in next 1000 digests' do
      expect(kg.match? 5, '2').to eq false
    end
  end

  describe 'superhash' do
    it 'returns hash' do
      digest = kg.md5.hexdigest 'abc0'
      expect(kg.superhash digest).to eq 'a107ff634856bb300138cac6568c0f24'
    end
  end
end
