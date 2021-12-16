require 'strscan'
# input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day16.in")

def hex_to_binary s
  [s].pack('H*').unpack('B*').first
end

def decode s
  # s = StringScanner.new bits
  while s.rest? || !s.rest.chars.all? { |x| x == "0" }
    # p "WHAT IS LEFT #{s.rest}"
    puts
    # header = version + id (6 bits)
    # get packet version
    v = s.scan(/\d{3}/)
    v = v.to_i(2)
    p "VERSION: #{v}"
    @vs += v

    # get packet type ID
    id = s.scan(/\d{3}/)
    id = id.to_i(2)
    # p "TYPE ID: #{id}"

    case id
    when 4 # literal binary num
      len = 0 # need to scan until whole packet is multiple of 4
      num = ""  # TODO
      b = s.scan(/\d{5}/)
      len += 4
      while b[0] != "0"
        num += b[1,4]
        b = s.scan(/\d{5}/)
        len += 4
      end

      # reached last group
      num += b[1,4]
      len += 4

      # p "BEFORE PADDING? #{s.rest}"
      # p "LENGTH? #{len}"
      # scan until len is multiple of 4
      until len % 4 == 0
        s.scan(/0/)
        len += 1
      end
      p "LITERAL VAL #{num.to_i(2)}"
      p "REST? #{s.rest}"

    else # is operator TODO cases for difft operators
      p "OPERATOR PACKET"
      i = s.scan /(0|1)/ # length type ID
      # p "LENGTH TYPE ID: #{i}"
      case i
      when "1" # len = number of subpackets
        n = s.scan /\d{11}/
        sps = n.to_i(2)
        p "SUBPACKET LENGTH: #{sps}"
        x = 0
        while x != sps
          x = StringScanner.new s.rest
          decode x
          x += 1
        end

      when "0" # len = number of actual bits
        n = s.scan /\d{15}/
        len = n.to_i(2)
        p "BITS LENGTH: #{len}"
        bits = s.scan(/.{#{len}}/)
        p "REMAINING BITS #{bits}"
        x = StringScanner.new bits
        decode x
      end
    end
  end
  p @vs
end

@vs = 0

# h = "38006F45291200"
h = "EE00D40C823060"
h = "8A004A801A8002F478"
h = "620080001611562C8802118E34"
b = hex_to_binary h
p "BINARY: #{b}"
s = StringScanner.new b
decode s
p "Part 1: #{@vs}"

# bits = input.first.chomp
# p bits
# b = hex_to_binary bits
# decode b, 0
