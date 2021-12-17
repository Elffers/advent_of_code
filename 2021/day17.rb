@tx=(20..30)
@ty=(-10..-5)

# input = "target area: x=269..292, y=-68..-44"
@tx=(269..292)
@ty=(-68..-44)

def hit x,y
  @tx.include?(x) && @ty.include?(y)
end

def step x, y, vel
  dx, dy = vel
  x += dx
  y += dy
  dy -=1

  if dx > 0
    dx-=1
  elsif dx < 0
    dx+=1
  end

  [x, y, [dx, dy]]
end

def step_until_hit vel
  vel0 = vel
  max_height = -100

  x = 0
  y = 0
  500.times do
    x, y, vel = step x, y, vel
    if y > max_height
      max_height = y
    end
    if hit x, y
      p "HIT: #{vel0}"
      p [x,y]
      puts
      puts "MAX: #{max_height}"
      return [true, max_height]
    end
  end
  [false, nil]
end

maxes = Hash.new { |h,k| h[k] = [] }
(-100..300).each do |dx|
  (-100..300).each do |dy|
    r, m = step_until_hit [dx, dy]
    if r
      maxes[m] << [dx,dy]
    end
  end
end

m = maxes.keys.max
p "Part 1: #{m}"

count = 0
maxes.each do |k, v|
  count += v.size
end
p "Part 2: #{count}"
