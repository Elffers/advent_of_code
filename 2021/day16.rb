require 'strscan'
input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day16.in")

class Packet
  attr_accessor :version, :type, :body, :length_type, :parent, :subpackets, :scanner, :sp_size

  def initialize v, t, parent, scanner
    @version = v
    @type = t
    @parent = parent
    @subpackets = []
    @scanner = scanner
  end

  def inspect
    {
      "version" => @version,
      "type" => @type,
      "act sps" => @subpackets.size,
      "desired sps" => @sp_size
    }
  end

  # dfs
  def val
    return body.to_i(2) if literal?
    sps = subpackets.map { |sp| sp.val }

    case @type
    when 4
      body.to_i(2)
    when 0 #sum - 1 or 2 subpkts
      # p "SUM: #{subpackets.size}"
      if sps.size == 1
        sps.first
      else
        sps.reduce :+
      end
    when 1 # mult - 1 or 2 subpkts
      case sps.size
      when 1
        sps.first
      when 2
        sps.reduce :*
      end
    when 2 # min - min value of all subpkts
      sps.min
    when 3 # max - max of all subpkts
      sps.max
    when 5 # gt - 2 subpkts only. val = 1 if sp1 > sp2, else 0
      if sps.size != 2
        puts "ERROR 5"
      end
      sps.first > sps.last ? 1 : 0
    when 6 # lt - 2 subpkts only. val = 1 if sp1 < sp2, else 0
      if sps.size != 2
        puts "ERROR 6"
      end
      sps.first < sps.last ? 1 : 0
    when 7 # eq - 2 subpkts only. val = 1 if sp1 = sp2, else 0
      if sps.size != 2
        puts "ERROR 7"
      end
      sps.first == sps.last ? 1 : 0
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

def parse bits, parent, sp_size=nil
  puts
  s = StringScanner.new bits

  sp_count = 0

  if parent && parent.length_type == "1"
    s = parent.scanner
  end

  while s.rest? && !s.rest.chars.all? { |x| x == "0" }
  if parent && parent.sp_size == parent.subpackets.size
    return
  end
    # header = version + id (6 bits)
    # get packet version
    v = s.scan(/\d{3}/)
    v = v.to_i(2)

    p "VERSION: #{v}"

    # get packet type ID
    id = s.scan(/\d{3}/)
    id = id.to_i(2)
    p "TYPE: #{id}"
    pkt = Packet.new v, id, parent, s
    if !parent.nil?
      if parent.sp_size.nil?
        parent.subpackets << pkt
        p "parent should not have sp_size: #{parent.inspect}"
      elsif !parent.sp_size.nil?
        if parent.subpackets.size < parent.sp_size
          parent.subpackets << pkt
          p "parent SHOULD have sp_size: #{parent.inspect}"
          p "sbpkt: #{pkt.inspect}"
        end
      end
    end

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
      # p "REST? #{[s.rest, s.rest?]}"
    elsif pkt.op?

      i = s.scan /(0|1)/ # length type ID
      pkt.length_type = i
      p "LENGTH_TYPE #{i}"

      case i
      when "1" # len = number of subpackets
        n = s.scan /\d{11}/
        sps = n.to_i(2)

        p "SPS #{sps}"
        pkt.sp_size = sps
        parse s.rest, pkt
        # fast forward scanner
      when "0" # len = number of actual bits
        n = s.scan /\d{15}/
        len = n.to_i(2)
        parse s.scan(/.{#{len}}/), pkt
      end
    end

  end
  pkt
end

# h = "D2FE28"
# h = "38006F45291200"
# h = "EE00D40C823060"
# h = "8A004A801A8002F478"
h = "620080001611562C8802118E34"
h = "C0015000016115A2E0802F182340"
h = "A0016C880162017C3686B18A3D4780"
# h = "C200B40A82"
# h = "04005AC33890"
# h = "880086C3E88112"
# h = "CE00C43D881120"
# h = "F600BC2D8F"
# h = "D8005AC2A8F0"
h = "9C005AC2F8F0"
h = "9C0141080250320F1802104A08"
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
puts
# p "Part 1: #{version_sum pkt}"
# p "SIZE: #{pkt.subpackets.size}" #????

# pkt.subpackets.each do |x|
#   p x.subpackets.size
# end
p "Part 2: #{pkt.val}"
