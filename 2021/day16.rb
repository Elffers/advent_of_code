require 'strscan'
input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day16.in")

class Packet
  attr_accessor :version, :type, :body, :length_type, :parent, :subpackets, :scanner

  def initialize v, t, parent, scanner
    @version = v
    @type = t
    @parent = parent
    @subpackets = []
    @scanner = scanner
  end

  def val
    if @type == 4
      body.to_i(2)
    end
  end

  def literal?
    @type  == 4
  end

  def op?
    @type != 4
  end
end

def hex_to_binary s
  [s].pack('H*').unpack('B*').first
end

def parse bits, parent
  s = StringScanner.new bits

  if parent && parent.length_type == "1"
    s = parent.scanner
  end

  while s.rest? && !s.rest.chars.all? { |x| x == "0" }
    puts
    # header = version + id (6 bits)
    # get packet version
    v = s.scan(/\d{3}/)
    v = v.to_i(2)

    p "VERSION: #{v}"

    # get packet type ID
    id = s.scan(/\d{3}/)
    id = id.to_i(2)
    p "TYPE ID: #{id}"
    pkt = Packet.new v, id, parent, s

    # set body/value
    if pkt.literal?
      num = ""
      # scan groups
      b = s.scan(/\d{5}/)
      while b[0] != "0"
        num += b[1,4]
        b = s.scan(/\d{5}/)
      end

      # reached last group
      if b[0] == "0"
        num += b[1,4]
      end
      pkt.body = num

      p "LITERAL VAL #{pkt.val}"
      p "REST? #{[s.rest, s.rest?]}"
    elsif pkt.op?

      # when 0 #sum - 1 or 2 subpkts
      # when 1 # mult - 1 or 2 subpkts
      # when 2 # min - min value of all subpkts
      # when 3 # max - max of all subpkts
      # when 5 # gt - 2 subpkts only. val = 1 if sp1 > sp2, else 0
      # when 6 # lt - 2 subpkts only. val = 1 if sp1 < sp2, else 0
      # when 7 # eq - 2 subpkts only. val = 1 if sp1 = sp2, else 0

      i = s.scan /(0|1)/ # length type ID
      pkt.length_type = i

      case i
      when "1" # len = number of subpackets
        n = s.scan /\d{11}/
        sps = n.to_i(2)
        p "SUBPACKET LENGTH: #{sps}"
        parse s.rest, pkt

      when "0" # len = number of actual bits
        n = s.scan /\d{15}/
        len = n.to_i(2)
        p "BITS LENGTH: #{len}"
        # bits = s.scan(/.{#{len}}/)
        # p "REMAINING BITS #{bits}"
        parse s.scan(/.{#{len}}/), pkt
      end
    end
    if !parent.nil?
      parent.subpackets << pkt
    end
  end
  pkt
end

h = "D2FE28"
h = "38006F45291200"
h = "EE00D40C823060"
h = "8A004A801A8002F478"
h = "620080001611562C8802118E34"
h = "C0015000016115A2E0802F182340"
h = "A0016C880162017C3686B18A3D4780"
h = input.first.chomp
b = hex_to_binary h

def version_sum root
  sum = 0
  queue = []
  queue << root
  while !queue.empty?
    curr = queue.shift
    sum += curr.version
    queue.concat curr.subpackets
  end
  sum
end

pkt = parse b, nil
p "Part 1: #{version_sum pkt}"
