if __FILE__ == $0
  discs = [
    [17, 5],
    [19, 8],
    [7, 1 ],
    [13, 7],
    [5, 1 ],
    [3, 0 ],
    [11, 0]
  ]

  sec = 0

  loop do
    positions = discs.map.with_index do |disc, i|
      size = disc.first
      init = disc.last
      (sec + i+1 + init) % size
    end

    if positions.all? { |pos| pos == 0 }
      p sec
      abort
    end

    sec += 1
  end
end
