input = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day17.in").split("\n")
# input = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day17test.in").split("\n")

state = Hash.new "."

input.each_with_index do |row, x|
  row.chars.each_with_index do |s, y|
    state[[x, y, 0]] = s
  end
end

def cycle(state)
  new_state = state.dup
  coords = state.keys
  x0, xn = coords.map { |c| c[0] }.min - 1, coords.map { |c| c[0] }.max + 1
  y0, yn = coords.map { |c| c[1] }.min - 1, coords.map { |c| c[1] }.max + 1
  z0, zn = coords.map { |c| c[2] }.min - 1, coords.map { |c| c[2] }.max + 1

  x0.upto(xn).each do |x|
    y0.upto(yn).each do |y|
      z0.upto(zn).each do |z|
        actives = 0
        neighbors = [
          [x-1, y-1, z-1], [x, y-1, z-1], [x+1, y-1, z-1],
          [x-1, y, z-1],   [x, y, z-1],   [x+1, y, z-1],
          [x-1, y+1, z-1], [x, y+1, z-1], [x+1, y+1, z-1],

          [x-1, y-1, z],   [x, y-1, z],   [x+1, y-1, z],
          [x-1, y, z],                    [x+1, y, z],
          [x-1, y+1, z],   [x, y+1, z],   [x+1, y+1, z],

          [x-1, y-1, z+1], [x, y-1, z+1], [x+1, y-1, z+1],
          [x-1, y, z+1],   [x, y, z+1],   [x+1, y, z+1],
          [x-1, y+1, z+1], [x, y+1, z+1], [x+1, y+1, z+1],
        ]

        neighbors.each do |n|
          i,j,k = n
          actives += 1 if state[[i,j,k]] == "#"
        end
        val = state[[x,y,z]]

        case val
        when "#"
          if !(actives == 2 || actives == 3)
            val = "."
          end

        when "."
          if actives == 3
            val = "#"
          end
        end
        new_state[[x,y,z]] = val

      end
    end
  end
  new_state
end


6.times do
  state = cycle state
end

count = state.values.count("#")

p "part 1: #{count}"



#     adjacent = [
#       [x-1, y-1, z-1], [x, y-1, z-1], [x+1, y-1, z-1],
#       [x-1, y, z-1],   [x, y, z-1],   [x+1, y, z-1],
#       [x-1, y+1, z-1], [x, y+1, z-1], [x+1, y+1, z-1],

#       [x-1, y-1, z],   [x, y-1, z],   [x+1, y-1, z],
#       [x-1, y, z],                    [x+1, y, z],
#       [x-1, y+1, z],   [x, y+1, z],   [x+1, y+1, z],

#       [x-1, y-1, z+1], [x, y-1, z+1], [x+1, y-1, z+1],
#       [x-1, y, z+1],   [x, y, z+1],   [x+1, y, z+1],
#       [x-1, y+1, z+1], [x, y+1, z+1], [x+1, y+1, z+1],
#     ]

