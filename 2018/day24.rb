require 'pp'
input = File.readlines("/Users/hsinghui/sandbox/advent_of_code/2018/inputs/day24.in").map { |x| x.strip }
pp input

# class Unit
# end

class Group
  attr_accessor :units, :hit_pts, :attack, :initiative

  def initialize units, hit_pts, damage, type, initiative, weaknesses, immunities
    @units      = units
    @hit_pts    = hit_pts
    @damage     = damage
    @type       = type
    @initiative = initiative
    @weaknesses = weaknesses
    @immunities = immunities
  end

  def effective_power
    @units * @damage
  end

  # "8233 units each with 2012 hit points (immune to radiation) with an attack that does 2 fire damage at initiative 5"
end

# target selection
#
# attacking
