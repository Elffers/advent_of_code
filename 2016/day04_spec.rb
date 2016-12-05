require_relative 'day04'

describe Decrypter do
  let(:d) { Decrypter.new }
  describe 'find_checksum' do
    it "returns checksum" do
      name = 'aaaaa-bbb-z-y-x-'
      actual = d.find_checksum name
      expect(actual).to eq 'abxyz'
    end

    it "returns checksum" do
      name ='not-a-real-room-'
      actual = d.find_checksum name
      expect(actual).to eq 'oarel'
    end
  end

  describe 'parse_room' do
    it "returns adds valid room to rooms" do
      encoding = 'aaaaa-bbb-z-y-x-123[abxyz]'
      d.parse_room encoding
      expect(d.rooms.map(&:id)).to eq [123]

      encoding = 'a-b-c-d-e-f-g-h-987[abcde]'
      d.parse_room encoding
      expect(d.rooms.map(&:id)).to eq [123, 987]

      encoding = 'not-a-real-room-404[oarel]'
      d.parse_room encoding
      expect(d.rooms.map(&:id)).to eq [123, 987, 404]
    end

    it "returns nil if not valid room" do
      encoding = 'totally-real-room-200[decoy]'
      d.parse_room encoding
      expect(d.rooms).to be_empty
    end
  end

  describe 'find_sum' do
    it 'returns sum of room ids' do
      encodings = ['aaaaa-bbb-z-y-x-123[abxyz]',
               'a-b-c-d-e-f-g-h-987[abcde]',
               'not-a-real-room-404[oarel]',
               'totally-real-room-200[decoy]']

      d.filter_rooms encodings

      expect(d.find_sum).to eq 1514
    end
  end

  describe 'decrypt' do
    it 'decrypts name' do
      name = 'qzmt-zixmtkozy-ivhz'
      id = '343'

      expect(d.decrypt(name, id)).to eq 'very encrypted name'
    end
  end
end
