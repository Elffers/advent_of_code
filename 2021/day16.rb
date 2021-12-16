require 'strscan'
input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day16.in")

def hex_to_binary s
  [s].pack('H*').unpack('B*').first
end

def decode bits
  s = StringScanner.new bits
  while s.rest? && !s.rest.chars.all? { |x| x == "0" }
    puts
    p "WHAT IS LEFT #{s.rest}"
    # header = version + id (6 bits)
    # get packet version
    v = s.scan(/\d{3}/)
    v = v.to_i(2)
    p "VERSION: #{v}"
    @vs += v

    # get packet type ID
    id = s.scan(/\d{3}/)
    id = id.to_i(2)
    p "TYPE ID: #{id}"

    case id
    when 4 # literal binary num
      num = ""
      b = s.scan(/\d{5}/)
      while b[0] != "0"
        num += b[1,4]
        b = s.scan(/\d{5}/)
      end

      # reached last group
      if b[0] == "0"
        num += b[1,4]
      end

      p "LITERAL VAL #{num.to_i(2)}"

      p "REST? #{[s.rest, s.rest?]}"
      return if !s.rest?

    else # is operator TODO cases for difft operators
      p "OPERATOR PACKET"
      i = s.scan /(0|1)/ # length type ID
      p "LENGTH TYPE ID: #{i}"
      case i
      when "1" # len = number of subpackets
        n = s.scan /\d{11}/
        sps = n.to_i(2)
        p "SUBPACKET LENGTH: #{sps}"
        x = 0
        while !s.rest?
          s = decode s.rest
          x += 1
        end

      when "0" # len = number of actual bits
        n = s.scan /\d{15}/
        len = n.to_i(2)
        p "BITS LENGTH: #{len}"
        # bits = s.scan(/.{#{len}}/)
        # p "REMAINING BITS #{bits}"
        decode s.scan(/.{#{len}}/)
      end

    end
  end
  p "VERSION SUM: #{@vs}"
  s
end

@vs = 0

h = "D2FE28"
h = "38006F45291200"
h = "EE00D40C823060"
h = "8A004A801A8002F478"
h = "620080001611562C8802118E34"
h = "C0015000016115A2E0802F182340"
h = "A0016C880162017C3686B18A3D4780"
h = input.first.chomp
b = hex_to_binary h
# b = "11010001010"
# b = "01010010001001000000000"
decode b
p "Part 1: #{@vs}"

# bits = input.first.chomp
# p bits
# b = hex_to_binary bits
# decode b, 0
