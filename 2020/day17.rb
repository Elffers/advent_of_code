input = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day17.in").split("\n")
# input = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day17test.in").split("\n")

state = Hash.new "."

input.each_with_index do |row, x|
  row.chars.each_with_index do |s, y|
    state[[x, y, 0, 0]] = s
  end
end

def cycle(state)
  new_state = state.dup
  coords = state.keys
  x0, xn = coords.map { |c| c[0] }.min - 1, coords.map { |c| c[0] }.max + 1
  y0, yn = coords.map { |c| c[1] }.min - 1, coords.map { |c| c[1] }.max + 1
  z0, zn = coords.map { |c| c[2] }.min - 1, coords.map { |c| c[2] }.max + 1
  w0, wn = coords.map { |c| c[3] }.min - 1, coords.map { |c| c[3] }.max + 1

  x0.upto(xn).each do |x|
    y0.upto(yn).each do |y|
      z0.upto(zn).each do |z|
        w0.upto(wn).each do |w|

          actives = 0
          (-1..1).each do |dx|
            (-1..1).each do |dy|
              (-1..1).each do |dz|
                (-1..1).each do |dw|
                  next if dx == 0 && dy == 0 && dz == 0 && dw == 0

                  actives += 1 if state[[x + dx, y + dy, z + dz, w + dw]] == "#"
                end
              end
            end
          end

          val = case state[[x,y,z,w]]
                when "#"
                  [2,3].include?(actives) ? "#" : "."
                when "."
                  actives == 3 ? "#" : "."
                end
          new_state[[x,y,z,w]] = val
        end
      end
    end
  end
  new_state
end


6.times do
  state = cycle state
end

count = state.values.count("#")

p "part 2: #{count}"
