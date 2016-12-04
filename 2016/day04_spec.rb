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
    it "returns id if valid room" do
      room = 'aaaaa-bbb-z-y-x-123[abxyz]'
      expect(d.parse_room room).to eq 123

      room = 'a-b-c-d-e-f-g-h-987[abcde]'
      expect(d.parse_room room).to eq 987

      room = 'not-a-real-room-404[oarel]'
      expect(d.parse_room room).to eq 404
    end

    it "returns nil if not valid room" do
      room = 'totally-real-room-200[decoy]'
      expect(d.parse_room room).to eq nil
    end
  end

  describe 'find_sum' do
    it 'returns sum of room ids' do
      rooms = ['aaaaa-bbb-z-y-x-123[abxyz]',
               'a-b-c-d-e-f-g-h-987[abcde]',
               'not-a-real-room-404[oarel]',
               'totally-real-room-200[decoy]']
      expect(d.find_sum rooms).to eq 1514
    end
  end
end
