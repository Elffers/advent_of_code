# The first floor contains a promethium generator and a promethium-compatible microchip.
# The second floor contains a cobalt generator, a curium generator, a ruthenium generator, and a plutonium generator.
# The third floor contains a cobalt-compatible microchip, a curium-compatible microchip, a ruthenium-compatible microchip, and a plutonium-compatible microchip.
# The fourth floor contains nothing relevant.

# init =
# [
#   %w[ F4 . .  .  .  .  .  .  .  .  .  .  ],
#   %w[ F3 . .  .  .  BM .  CM .  DM .  FM ],
#   %w[ F2 . .  .  BG .  CG .  DG .  FG .  ],
#   %w[ F1 E AG AM .  .  .  .  .  .  .  .  ]
# ]
#
# floors can be represented as (first to fourth):
[
  "1100000000",
  "0010101010",
  "0001010101",
  "0000000000"
]

# represents node of graph
class State
  attr_accessor :floors, :moves, :elevator

  def initialize floors, moves, elevator
    @floors = floors
    @moves = moves
    @elevator = elevator
  end

  def ==(state)
    self.floors == state.floors
  end

  def done?
    floors.last.chars.all? { |el| el == "1" }
  end
end

# generators have even indexes
# chips have odd indexes
# move is valid if chip (y is odd) goes to floor (x) where y-1
# (corresponding generator) is present or all other generators (odd indices
# of x) are nil
# just check if configuration is valid

# def valid_state? floor
#   rtgs, chips = floor.partition.with_index { |el, i| i.even? }

#   return true if rtgs.all? { |el| el == "0" }
#   chips.each_with_index do |chip, i|
#     if chip == "1"
#       return false if rtgs[i] != "1"
#     end
#   end
#   true
# end

class Column
  attr_accessor :state, :elevator

  def initialize initial_floors
    @init = state
    @elevator = 0
  end

  def valid? floor
    # chip can't be with another rtg unless connected
    # only need to check one floor since assume all other floors are valid at
    # time of move
  end

  def next_moves state
    # check if visited here
    # elevator moves up or down, takes 1 or two elements
    elevator_pos = state.elevator
    up = elevator_pos + 1
    down = elevator_pos - 1

    elevator_positions = []
    elevator_positions << up if up < 4
    elevator_positions << down if down > 0

    moves = state.moves + 1

    old_floor = state.floors[elevator_pos]

    elevator_positions.each do |pos|
      new_floor = state.floors[pos]
      combos(floor).each do |combo|
      end
    end

  end

  # finds all possible element combinations that can be carried in the
  # elevator
  def combos floor
    indices = []
    floor.each_char.with_index do |x, i|
      indices << i if x == '1'
    end

    indices.combination(1).to_a + indices.combination(2).to_a
  end

  def new_floor_state(old_floor, combo, new_floor)
    # "110000", [0], "000000"
  end

  def shortest_path
    queue = []
    visited = []

    current = State.new
    queue << current
    visited << State.floors

    while !queue.empty?
      current = queue.shift

      return current.moves if current.done?

      moves = next_moves current
      moves.each do |move|
        queue << move
        visited << move.floors
      end
    end
  end
end

