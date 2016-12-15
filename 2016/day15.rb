class Disc
  attr_accessor :size, :init

  def initialize size, init
    @size = size
    @init = init
  end
end

if __FILE__ == $0
  # disc1 = Disc.new 5, 4
  # disc2 = Disc.new 2, 1

  disc1 = Disc.new 17, 5
  disc2 = Disc.new 19, 8
  disc3 = Disc.new 7, 1
  disc4 = Disc.new 13, 7
  disc5 = Disc.new 5, 1
  disc6 = Disc.new 3, 0
  disc7 = Disc.new 11, 0

  discs = [
    disc1,
    disc2,
    disc3,
    disc4,
    disc5,
    disc6,
    disc7
  ]

  sec = 0
  loop do

    pos = discs.map.with_index do |disc, i|
      (sec + i+1 + disc.init) % disc.size
    end

    if pos.all? { |p| p == 0 }
      p sec
      abort
    end

    sec += 1
  end
end
